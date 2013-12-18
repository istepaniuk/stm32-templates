TARGET = blink-asm

TOOLCHAIN = ../toolchain
AS = $(TOOLCHAIN)/bin/arm-none-eabi-as
LD = $(TOOLCHAIN)/bin/arm-none-eabi-ld

ASFLAGS += -mcpu=cortex-m3 
ASFLAGS += -mthumb

LSCRIPT = ./ld/stm32.ld
LFLAGS += -T $(LSCRIPT)

all: $(TARGET).elf

$(TARGET).elf: blink.o $(LSCRIPT)
	@echo
	@echo Linking: $<
	$(LD) $(LFLAGS) -o $@ $<

%.o: src/%.s
	@echo
	@echo Assembling: $<
	$(AS) $(ASFLAGS) -o $@ $< -alh=$*.lst

clean:
	@echo
	@echo Cleaning:
	$(RM) *.o 
	$(RM) *.elf 
	$(RM) *.lst
