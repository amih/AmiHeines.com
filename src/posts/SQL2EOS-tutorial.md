---
title: "SQL2EOS tutorial"
description: "Initial explanation of how this works"
date: 2021-03-09T19:00
thumb: "SQL2EOS.png"
tags: SQL2EOS
---

SQL2EOS is built and developed on a custom made Meta_II meta-compiler, so before explaining SQL2EOS I need to explain Meta_II. If you don’t care about the whole stack and just want to skip to the SQL2EOS, feel free to do so.

I was always fascinated by computer languages and learned many over the years. I also read some thick books about compilers and language design. Not light read. Meta_II was a refreshing surprise as it is very light weight compared to the compiler books I’ve read. It is based on a really short scientific paper:

META II: A Syntax-Oriented Compiler Writing Language.
Schorre, D. V.
In Proceedings of the 1964 19th ACM National Conference,
ACM Press, New York, NY, 41.301-41.3011, 1964.
available as http://doi.acm.org/10.1145/800257.808896

Before reading that paper, I actually found [this page](http://www.bayfronttechnologies.com/mc_tutorial.html) which explains Meta_II in depth.

I would like to write a detailed explanation of Meta_II but I want to start from the bottom and work my way up from there. Also, I will assume you know javascript but unlike the other web page or the original paper which assume knowledge of assembly language, I will explain the pseudo-assembler and how to easily understand it.

The whole SQL2EOS code is written in javascript but that is tricky to understand since it is a generic interpreter for a custom made assembly-flavor language. The way it works, is that there is an assembly language program in a string called code and a string with an SQL command called input. These 2 strings are the parameters for the interpreter which is a javascript function. The function runs the interpreter, which deciphers the code and extracts the info from the input. The function returns a string called output which contains the EOSIO smart contract in plain CPP source code based on the /smart-contract-guides/data-persistence from the developers.eos.io web site.

So, without further ado, let’s dive in to the assembler. This assembler is not “real” it is not intended to be compiled to machine code and will never run on a CPU. It is a very simple language that helps glue all the different parts of the Meta_II system together.

1st rule in the assembly language is that all commands appear on a single line preceded with a tab character.

All commands are evaluated sequentially, line by line. Some commands have a parameter, others don’t.

There are some hidden variables in assembler, they are considered global and are few and frequently used.

There are special commands that make the program jump to other lines instead of going to the next line in the file. These jump or goto commands have a string parameter called label which tells the interpreter to look for the label in a line which doesn’t start with a tab character and the line contains nothing else except the label.

Oh, I almost forgot, there is also a function call construct which jumps to a label but uses a stack, a simple javascript array which gets some info pushed to it and when the end of the function is reached – marked by a return command, the stack is popped with info of where to return to and what to do with the result.

Since this is a made up assembler, it is not dealing with the primitive data types of a typical CPU or RAM but our basic building blocks of interest, literal strings, numbers and special identifiers.

Here is a short list of commands in our custom assembler,

| Command   | A little explainer |
|-----------|--------------------|
| TST ‘abc’	| this command checks if the next part of the input is exactly equal the string parameter, in this example: abc |
| ID        | skip white space and if the next part of the input is a legal identifier, save it in a global variable for later use and set the global flag to true |
| B L12	    | branch to label L12, in other words, jump to the next command after the label L12 |
| BT L13	| similar to the above, but only if the global flag (called flag obviously) is True |
| BF L14	| Branch if flag is False |
| CL ‘xyz’	| There is a global variable to assist in editing the next line of output, Copy Literal to that output buffer |
| CI	    | Copy the Identifier from the global variable holding the latest scanned identifier to the output buffer |
| CLL FUNC	| Make a function call, save the return location and some additional variables and goto the next command after the label |
| R	        | Return from the function call |

Now if you want to read some assembly code, go to the https://amiheines.com/meta_ii-playground-page/ and click the line with “ca05 added STORE AND LOAD VARIABLES”

That page is organised from left to right with 3 large text areas,
input – code – output.

You will see the Meta_II compiler which is hard coded on that page.

If you write a suitable input, the interpreter will run automatically 3 seconds after the last key stroke in the input of the code text areas.

Instead of typing an input, you can click on the line above the text area “ia15. meta_ii with loops, use with ca05” and the interpreter will immediately run. No need to wait 3 seconds, since you’re not manually editing but clicking a pre-made input.

The first command is ADR which is like a function call but a special one, it is like the main() function in C or CPP which is the starting point of the program.

The matching special command is END which is the end of the program.

Other commands I neglected to tell you about are:

BE	Branch if the error global variable is true to a special error reporting function and exit
OUT	output the global variable output buffer to the actual output string of the program
Now you can read most of the program and make sense of it! Right?

		ADR METAII
	METAII
		TST '.SYNTAX'
		BF L1
		ID
		BE
		CL 'ADR '
		CI
		OUT
	L2
		CLL ST
		BT L2
		SET

Let me describe the first few lines in the snippet above. The first line is the beginning of the program. The name of the program is METAII and it jumps to the label on the next line with the same name.

There is nothing to do on a label line, so we move to the following line which says to test for a string in the input file, “.SYNTAX”

Well, the input file does start with .SYNTAS so this is working! The input pointer is moved past the string and the flag is set to true.

The next line has a Branch if flag is false, but since the flag is actually true, we ignore this command and move to the next line.

The next line is ID, so we check if there is a “legal” identifier after skipping any white spaces. A legal identifier is like a variable in many computer languages, starting with a letter in the range a-z and followed by optional additional letters or digits. Well, we see a legal identifier in the input:

METAIIWITHLOOPS

We store it for later use in a global variable which is a part of the interpreter for the assembler and move on to the next command.

BE, or Branch if Error is also ignored, there was no error in the previous step, moving on…

CL ‘ADR ‘ will copy the literal “ADR ” to the output buffer.

CI will append the latest identifier “METAIIWITHLOOPS” to the output buffer.

OUT will take the output buffer and copy it to the output string and clear the output buffer, effectively finalizing the output of a line.

L2 is just a label, so ignored,

CLL ST is a function call. The program jumps to the ST label and will return once that call is completed with an R command.

BT L2 means jump if the global flag is true to L2 which we recently passed!

This is the assembler equivalent of a do-while loop:

	do {
	st();
	} while (flag);

As long as the variable named flag is True, go back and re run the body of the loop, which simply contains the call to the st() function.

Eventually, the flag will be false and the loop will end.

The next command is SET which simply sets the global flag to true.

This is in preparation for the next commands which will be surprised if the flag is not true which is the “normal” state. After all, the loop ended and nothing unusual happened, so SET makes sure the rest of the code agrees.

As you can see, assembly is very verbose and tedious. Programs tend to be very long and not so human friendly.

We had enough of assembly. Now I’m contemplating on where to move next, there are two possibilities. One is to move up in the abstraction stack and discuss the high-level-language which Meta_II definition as well as the SQL2EOS compiler are written in.

The other is to move deeper in the stack to the lowest level – the interpreter which makes the assembler work.

Lets start with the latter. The whole interpreter is written in a single javascript file, https://github.com/amih/META_II/blob/master/index.js and is not too difficult to follow. It has 180 lines and contains a single object called vm.

If you look at the bottom of the file, you will see the META_II key which is the main function taking two variables, an input string and a code string. This function initializes many variables and then enters the main loop which processes the commands, one after another here:

	vm.InterpretOp();

The loop stops if the global variable for the exitLevel is true and then the function returns the string in outbuf:

	if(vm.exitlevel){ return vm.outbuf; }

Most of the javascript code is broken down to the handling of each of the assembly commands. I hope the code is easy enough to decypher.

The special property of the Meta_II compiler, is that it is actually a whole class of compilers which share the peculiar property that you can produce them as output based on a high-level definition.

If you use the ia15… input and the ca05… code, you will see that the output is very similar to the code. Now the surprising property of Meta_II is that if you replace the code with the new code from the output text area, the interpreter will trigger another run and will produce new output. The new output is identical to the code!!!

If you think of the code in the center as a function transforming the input text to an output text, then this is a stable point where no matter how many times you copy the output to the code area, the result won’t change anymore.

This is the main technique for extending and manipulating the Meta_II code without manually dealing with the assembly implementation. The main focus should be on the high definition of the language which is made of syntax equations mixed with output commands in curly brackets.

I want to very briefly explain this high level language, soon ew reach the SQL2EOS compiler, I promise.

Each Meta_II high-level definition starts with a line with the exact string:
“.SYNTAX” followed by the language name and ends with a line which contains just “.END”, see for example:

	.SYNTAX METAIIWITHLOOPS
	... some syntax equations here...
	... some syntax equations here...
	... some syntax equations here...
	.END

Between the start and end there are BNF syntax equations, which define the rules of the language we are defining a compiler for.

The equations start with the rule name, followed by an equal sign, followed by the rule definition and finished with a semicolon.

Each one can use other equations in the program. This is not a sequential language but a declarative language. If a rule fails, no harm done, other rules are checked. Once a rule succeeds, there are output commands interspersed which tell the compiler to output either literal strings or use recently identified parts of the source.

Consider the followinf syntax equation:

	METAIIWITHLOOPS = '.SYNTAX' .ID {'ADR ' *} $ ST '.END' {'END'};

This line defines a syntax rule, called “METAIIWITHLOOPS”

we will ignore the output commands in {} for now. This rule works successfully if the input has the literal string “.SYNTAX” followed by a legal identifier followed by zero or more expressions matching the ST rule, followed by the string “.END”.

Now, if this rule passes all these tests, it will output a new line with the string: “ADR ” followed by the content of the identifier, and after the zero or more ST rules are satisfied and the “.END” is found, it will output the string “END” in a separate line.

The high level language has a very succinct syntax. It uses $ to signify “zero-or-more” and a / to signify either-or sub-rules.

I hope you understand the connection between the high level language and the low level assembler.

So, finally we get to the SQL2EOS compiler.

This should be easier now that we have all the above under our belt.

If you follow the first four steps in the https://amiheines.com/meta_ii-playground-page/ page, you have created the SQL2EOS compiler. On the left side is the high-level definition of the SQL2EOS compiler, in the center text area is the assembly code of the Meta_II compiler used to make the output which is on the right side.

The Meta_II used is an extended version with 2 additional features.

1. Saving identifiers to dynamically named variables or to dynamically named arrays
2. Looping over an array where the body of the loop has an index variable to be able to refer to items in the array

These new features are required to parse and use the table name in different parts of the output and recall the fields and their types in several different places so they can be correctly used in the output.

This is how a simple:

	CREATE TABLE posts (postid uint64, title string, createdat uint64)

Is turned into a full blown EOSIO compatible smart contract with a multi_index table, and insert, update and del actions.

The compiler is not production ready. The primary index is hard coded as “user” and there are no secondary indexes.

In the next iteration, the SQL will have multiple TABLE definitions and the Meta_II can have cleaner syntax.

I think this is too long as it is, so I will say, good night!