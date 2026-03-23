#!/bin/bash
cd /home/ami/dev/work/amiheines.com/PLAN
cat PLAN_amiheinesConsultant.md > /tmp/combined_plan.md
for w in $(seq -w 1 21); do
  echo -e "\n\n\\\\newpage\n\n" >> /tmp/combined_plan.md
  cat TODO_w${w}.md >> /tmp/combined_plan.md
done
sed -i 's/🔗/[chain]/g; s/✅/[OK]/g; s/🟡/[WIP]/g; s/❌/[NO]/g; s/🤖//g' /tmp/combined_plan.md

# Write a small Lua filter that makes all tables wrap text in cells
cat > /tmp/wrap-tables.lua << 'LUAEOF'
function Table(tbl)
  -- Set all column widths to equal proportions so text wraps
  local ncols = #tbl.colspecs
  for i, spec in ipairs(tbl.colspecs) do
    tbl.colspecs[i] = {spec[1], 1.0 / ncols}
  end
  return tbl
end
LUAEOF

pandoc /tmp/combined_plan.md \
  -o AmiHeines_BusinessPlan.pdf \
  --pdf-engine=lualatex \
  --lua-filter=/tmp/wrap-tables.lua \
  -V geometry:margin=0.5in \
  -V fontsize=10pt \
  -V 'mainfont=DejaVu Sans' \
  -V 'monofont=DejaVu Sans Mono' \
  -V colorlinks=true \
  -V linkcolor=blue \
  -V urlcolor=blue \
  --toc \
  --toc-depth=3 \
  -V 'title=Business \& Domain Organization Strategy' \
  -V 'subtitle=Ami Heines — Blockchain Infrastructure Consulting' \
  -V 'date=March 2026'
