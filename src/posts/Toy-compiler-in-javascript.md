---
title: "Toy compiler in javascript"
description: "Playing with dangerous ancient dark magic code"
date: 2021-03-03T19:00
thumb: "META_II.png"
tags: META-II
---

I’ve always wanted to build my own compiler. It seemed a hard problem to tackle and a growing opportunity for me as a developer. I needed a good reason to actually get my hands dirty and stop reading books and ebooks on how to do it.

The best starting point I wanted to use is META_II. There is something magical about the short program in a completely bizarre language which compiles to itself and can be extended and preserve the property of being able to compile itself.

The first complete compiler I created yesterday is still very limited in its ability and lacks important language features. It is very ugly in its rules and syntax but it works for the use case I need it and it is all mine 🙂

It is not a polished product for general public consumption but very useful and a good starting point for additional extensions and improvements.

Now that I have the basic features I wanted and they actually work, I can put it to use and create a compiler that reads SQL flavor table definitions and converts that to eosio smart contract C++ which can then be further developed or uploaded as is to an EOS compatible blockchain.

The idea of SQL2EOS is that you write simplified SQL CREATE TABLE and it will have all the info it needs to output a valid C++ smart contract code with a multi-index table.

The SQL syntax is cleaner and doesn’t have repeating parts where as the C++ code does have longer, more verbose and confusing links between different parts of the code to reach the same result – a working table for user data.

Anyway, the META_II I extended and melded to my liking is still a work in progress and has some ugly parts. It is fairly easy to rewrite and I will do it soon and explain how, so you can follow along and use it for something else if you want.

The problem with META_II is that you need to be able to think in at least 4 different languages at the same time, this is hard. There is the “substrate language” which in my case is javascript and the usage is pretty straight forward, so not much brain power invested there. The second is the pseudo-assembler which is written on top of the substrate language, I chose to implement it as an interpreter. The javascript runs on the code file which is a text file which superficially looks like assembler but has special op-codes or commands which are processed in a large switch case in a loop in the javascript. Next up in the abstraction chain is the META_II high level language which is a mix of BNF equations that define the input language, intermixed with output commands that will create the output file in the target language.

Oh my! After bolding the different languages and explaining the relationships between them, I think there are actually 5 languages…

Not only that, but you need to be able to reasonably do “dry runs” in the different languages and debug all of them, sometimes with the help of caveman debugging to level the playing field of the multiple languages sitation.

Since it takes time to grok a programming language and feel fluent in it, and since META_II introduces at least 2 languages – the pseudo-assembler and the META_II high level language, it takes time and effort to overcome the initial learning curve.

The worst part is that the 5 languages are not static. Meaning, once you understand them and know what you can do, you realize they need to be extended and you keep changing them to suite your needs. This is not like adding a function, but adding a language concept altogether. Do you need a missing control structure? Are all variables global and you need the mechanism of scoping them to functions? Hint: META_II is brutally minimalistic and you need to add loops, variables, operators and more…

I added 2 things I needed for my task, one is a way to store dynamic arrays of values and the other is a looping construct for the output.

I also separated the stages of collecting info from the source SQL language and outputting the needed C++ smart contract since it wasn’t an easy one-to-one transformation from the SQL to the EOSIO C++ smart contract.

Want to play with the META_II and the demo SQL2EOSIO compiler? I should add a link for instant gratification here.