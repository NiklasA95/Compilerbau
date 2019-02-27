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

### [0.7.1] - 2019-02-28
#### Added
- more examples

### [0.7.0] - 2019-02-28
#### Added
- 3 example programs from Wikipedia

### [0.6.0] - 2019-02-27
#### Added
- scripts for Unix and Windows running LEX and YACC and starting `pl0-parser.exe`

### [0.5.1] - 2019-02-27
#### Fixed
- missing `;` (pl0-parser, line 42)
- argument `&$2` instead of `$2` (pl0-parser, line 75)

### [0.5.0] - 2019-02-27
#### Changed
- pl0-parser
- pl0-compiler

### [0.4.0] - 2019-02-26
#### Changed
- pl0-parser
- pl0-compiler

### [0.3.0] - 2019-02-25
#### Changed
- pl0-parser

### [0.2.0] - 2019-01-07
#### Added
- rough sketch of pl0-parser
- updated pl0-compiler

### [0.1.0] - 2019-01-04
#### Added
- pl0-scanner
- testable pl0-scanner (gives feedback with printf)
- pl0 example file



