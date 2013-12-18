TARGET = blink-plain

TOOLCHAIN = ../toolchain
AS = $(TOOLCHAIN)/bin/arm-none-eabi-as
LD = $(TOOLCHAIN)/bin/arm-none-eabi-ld
CC = $(TOOLCHAIN)/bin/arm-none-eabi-gcc
OC = $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
OD = $(TOOLCHAIN)/bin/arm-none-eabi-objdump
OS = $(TOOLCHAIN)/bin/arm-none-eabi-size

ASFLAGS += -mcpu=cortex-m3 
ASFLAGS += -mthumb

CFLAGS += -mcpu=cortex-m3 
CFLAGS += -mthumb 
CFLAGS += -g 
CFLAGS += -O0 
CFLAGS += -fno-common

CFLAGS += -I./inc
CFLAGS += -I./src

LSCRIPT = ./ld/stm32.ld
LFLAGS += -T$(LSCRIPT)

OBJS = inc/startup_stm32f10x_md_vl.o src/main.o inc/stm32f10x_rcc.o inc/stm32f10x_gpio.o

all: $(TARGET).elf

$(TARGET).elf: $(OBJS)
	@echo
	@echo Linking: $@
	$(LD) $(LFLAGS) -o $@ $^
	$(OD) -h -S $(TARGET).elf  > $(TARGET).lst

main.o: src/main.c
	@echo
	@echo Compiling: $<
	$(CC) -c $(CFLAGS) -I. src/main.c -o src/main.o

%.o: inc/%.c
	@echo
	@echo Compiling: $<
	$(CC) -c $(CFLAGS) -I. $< -o inc/$@

%.o: inc/%.S
	@echo
	@echo Assembling: $<
	$(AS) $(ASFLAGS) -o inc/$@ $< -alh=inc/$*.lst

clean:
	@echo
	@echo Cleaning:
	$(RM) $(OBJS)
	$(RM) *.o 
	$(RM) src/*.o
	$(RM) inc/*.o
	$(RM) *.elf
	$(RM) *.lst
