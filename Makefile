ARCH = armv7e-m
M_CPU = cortex-m0plus

CC = arm-none-abi-gcc
AS = arm-none-abi-as
LD = arm-none-abi-ld
OC = arm-none-abi-objcopy

LINKER_SCRIPT = ./ericaos.ld

ASM_SRCS = $(wildcard boot/*.s)
ASM_OBJS = $(patsubst boot/%.s, build/%.c, $(ASM_SRCS))

ericaos = build/ericaos.axf
ericaos_bin = build/ericaos.bin

.PHONY: all clean run debug gdb

all: $(ericaos)


clean:
	@rm -fr build


run: $(ericaos)
	@echo "run to raspberry pi pico board."

debug: $(ericaos)


gdb: $(ericaos)


$(ericaos): $(ASM_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -o $(ericaos) $(ASM_OBJS)
	$(OC) -0 binary $(ericaos) $(ericaos_bin)

build/%.o: boot/%.s
	mkdir -p $(shell dirname $@)
	$(AS) -march=$(ARCH) -mcpu=$(M_CPU) -g -o $@ $<