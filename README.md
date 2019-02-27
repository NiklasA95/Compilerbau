# Compilerbau
Repository for the "Compilerbau" lecture of Prof. Winfried Bantel

## Run LEX and YACC on Windows
1. flex pl0-scanner.l
2. bison -d pl0-parser.y 
3. gcc -o pl0-parser.exe pl0-parser.tab.c
4. Run pl0-parser.exe
5. Type in Code you want to parse. Press Enter. 

## Changelog
All notable changes to this project will be documented in this file.

### [0.1.0] - 2019-01-04
#### Added
- pl0-scanner
- testable pl0-scanner (gives feedback with printf)
- pl0 example file

### [0.1.1] - 2019-01-07
#### Added
- rough sketch of pl0-parser
- updated pl0-compiler

### [0.1.2] - 2019-02-25
#### Updated
- pl0-parser

### [0.1.3] - 2019-02-26
#### Updated
- pl0-parser
- pl0-compiler

### [0.1.4] - 2019-02-27
#### Updated
- pl0-parser
- pl0-compiler




