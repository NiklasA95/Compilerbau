@echo off
flex "pl0-scanner.l"
bison -d "pl0-parser.y"
gcc -o "pl0-parser.exe" "pl0-parser.tab.c"
"pl0-parser.exe"
