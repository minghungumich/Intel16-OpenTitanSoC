COMMON = common
ASM = src_asm
C = src_c
HEX = hex
TESTDATA = test_data
PIN = pin
SRC_C =
SRC_S = gpio
WEST_IO = ../../apr/platforms/intel16/gpio/hl_4slice_west_io/lef/hl_4slice_west_io.fill.lef
SOUTH_IO = ../../apr/platforms/intel16/gpio/hl_8slice_south_io/lef/hl_8slice_south_io.fill.lef

ifdef SRC_C
TEST = $(SRC_C)
SRC = $(C)/$(SRC_C).c
else
TEST = $(SRC_S)
SRC = $(ASM)/$(SRC_S).s
endif

CRT = $(COMMON)/crt.s
LINKERS = $(COMMON)/linker.lds
ASLINKERS = $(COMMON)/aslinker.lds

DEBUG_FLAG = -g
CFLAGS =  -mno-relax -march=rv32im -mabi=ilp32 -nostartfiles -std=gnu11 -mstrict-align -mno-div 
OFLAGS = -O0
ASFLAGS = -mno-relax -march=rv32im -mabi=ilp32 -nostartfiles -Wno-main -mstrict-align
OBJFLAGS = -SD -M no-aliases 
OBJDFLAGS = -SD -M numeric,no-aliases

GCC = riscv64-unknown-elf-gcc
OBJDUMP = riscv64-unknown-elf-objdump
AS = riscv64-unknown-elf-as
ELF2HEX = elf2hex

# Programs
all:

compile: $(CRT) $(LINKERS)
	$(GCC) $(CFLAGS) $(OFLAGS) $(CRT) $(SRC) -T $(LINKERS) -o program.elf
	$(GCC) $(CFLAGS) $(DEBUG_FLAG) $(CRT) $(SRC) -T $(LINKERS) -o program.debug.elf
assemble: $(ASLINKERS)
	$(GCC) $(ASFLAGS) $(SRC) -T $(ASLINKERS) -o program.elf 
	cp program.elf program.debug.elf
disassemble: program.debug.elf
	$(OBJDUMP) $(OBJFLAGS) program.debug.elf > program.dump
	$(OBJDUMP) $(OBJDFLAGS) program.debug.elf > program.debug.dump
	rm program.debug.elf
hex: program.elf
	$(ELF2HEX) 4 4096 program.elf > program.hex
	cp program.hex $(HEX)/$(TEST).hex
	python $(TESTDATA)/trim.py $(TEST)
	rm program*

program: compile disassemble hex
	@:

debug_program:
	gcc -lm -g -std=gnu11 -DDEBUG $(SRC) -o debug_bin

assembly: assemble disassemble hex
	@:

clean:
	rm -rvf program.hex program.dump program.debug.dump program.elf program.debug.elf debug_bin	\

csv:
	cd $(PIN) && \
	python parse.py $(SOUTH_IO) horizontal pin_south.csv && \
	python parse.py $(WEST_IO) vertical pin_west.csv

pin: csv
	cd $(PIN) && python pin_south.py && python pin_west.py

nuke:	clean
