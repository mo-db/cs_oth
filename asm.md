[https://www.youtube.com/watch?app=desktop&v=Jk7Ul2hKqxs&t=118s]
[https://www.youtube.com/watch?v=Ps0JFsyX2fU]
# ARM vs X86-64 vs RISC-V
- `x86` -> follows CISC CPU design
  - `CISC` -> Complex Instruction Set Computing
  - `closed ISA` Instruction Set Architecture -> Intel and Amd have license
  - complex instructions -> multiple instructions in a single statement
  - can `manipulate memory directly`

- `ARM` -> Advanced RISC Machine -> follows RISC CPU design
  - `RISC` -> Reduced Instructions Set Computing
  - `closed ISA` -> Arm limited has license 
  - simpler instruction set -> power efficiency
  - requires `seperate load and store instructions for memory manipulation`

[https://www.youtube.com/watch?v=9s8hPmCZ0mk]
- `RISC-V` -> follows RISC CPU design
  - `open ISA` -> no license needed
  - at the moment most relevant for embedded - but debian 13 will support it

# x86
[https://docs.oracle.com/cd/E26502_01/html/E28388/eoiyg.html]
- `Directives` or Pseudo-Op's -> start with .
- syntax dialects
  - Linux:	nasm, as, gcc	NASM, AT&T	Most common setup
  - Windows	ml.exe, nasm	MASM, NASM	Use with Visual Studio
  - Cross-platform	nasm, fasm	NASM	Good for bare metal/bootloaders
  - C/C++	gcc, clang	AT&T, Intel	Can include inline assembly







    - 
