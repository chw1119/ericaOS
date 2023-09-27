ARCH = armv6-m
M_CPU = cortex-m0

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy

LINKER_SCRIPT = ./ericaos.ld

ASM_SRCS = $(wildcard boot/*.s)
ASM_OBJS = $(patsubst boot/%.s, build/%.o, $(ASM_SRCS))

ericaos = build/ericaos.axf
ericaos_bin = build/ericaos.bin

.PHONY: all clean run debug gdb

all: $(ericaos)


clean:
	@rm -fr build


run: $(ericaos)
	@echo "run to raspberry pi pico board."

debug: $(ericaos)
	@echo "run to raspberry pi pico board."

gdb: $(ericaos)
	@echo "run to raspberry pi pico board."

$(ericaos): $(ASM_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -o $(ericaos) $(ASM_OBJS)
	$(OC) -0 binary $(ericaos) $(ericaos_bin)

build/%.o: boot/%.s
	mkdir -p $(shell dirname $@)
	$(AS) -march=$(ARCH) -mthumb -mcpu=$(M_CPU) -g -o $@ $<