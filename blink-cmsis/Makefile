TARGET = blink-cmsis

TOOLCHAIN = ../toolchain
AS = $(TOOLCHAIN)/bin/arm-none-eabi-as
LD = $(TOOLCHAIN)/bin/arm-none-eabi-ld
CC = $(TOOLCHAIN)/bin/arm-none-eabi-gcc
OC = $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
OD = $(TOOLCHAIN)/bin/arm-none-eabi-objdump
OS = $(TOOLCHAIN)/bin/arm-none-eabi-size

ASFLAGS += -mcpu=cortex-m3
ASFLAGS += -mthumb
ASFLAGS += -Wall 
ASFLAGS += -c 
ASFLAGS += -fmessage-length=0 

CFLAGS += -mcpu=cortex-m3
CFLAGS += -mthumb
CFLAGS += -g
CFLAGS += -O0
CFLAGS += -Wall
CFLAGS += -fmessage-length=0
CFLAGS += -ffunction-sections 
CFLAGS += -fdata-sections

LSCRIPT = ./ld/stm32.ld
LFLAGS += -nostdlib
LFLAGS += -static
LFLAGS += -T$(LSCRIPT)

DEFS += -DSTM32F10X_MD_VL
DEFS += -DUSE_STDPERIPH_DRIVER

CMSISSRC += ./lib/CMSIS/CM3/CoreSupport/core_cm3.c 
CMSISSRC += ./lib/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c
STSRC += ./lib/STM32F10x_StdPeriph_Driver/src/misc.c
STSRC += ./lib/STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c
STSRC += ./lib/STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c
STSRC += ./lib/STM32F10x_StdPeriph_Driver/src/stm32f10x_exti.c

SRC += ./src/main.c
SRC += ./src/stm32f10x_it.c
SRC += $(CMSISSRC)
SRC += $(STSRC)
		
ASRC = ./lib/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/gcc/startup_stm32f10x_md_vl.S

INCLUDE += -I./src
INCLUDE += -I./lib/CMSIS/CM3/DeviceSupport/ST/STM32F10x
INCLUDE += -I./lib/CMSIS/CM3/CoreSupport
INCLUDE += -I./lib/STM32F10x_StdPeriph_Driver/inc
INCLUDE += -I$(TOOLCHAIN)/arm-none-eabi/include
INCLUDE += -I$(TOOLCHAIN)/lib/gcc/arm-none-eabi/4.5.1/include
INCLUDE += -I$(TOOLCHAIN)/lib/gcc/arm-none-eabi/4.5.1/include-fixed

OBJS = $(ASRC:.S=.o) $(SRC:.c=.o)

all: $(TARGET).elf

$(TARGET).elf: $(OBJS)
	@echo	
	@echo Linking: $@
	$(LD) $(LFLAGS) -o $@ $^
	$(OD) -h -S $(TARGET).elf > $(TARGET).lst
		
flash: $(TARGET).elf size
	@echo
	@echo Creating .hex and .bin flash images:
	$(OC) -O ihex $< $(TARGET)_firmware.hex
	$(OC) -O binary $< $(TARGET)_firmware.bin
	
size: $(TARGET).elf
	@echo
	@echo == Object size ==
	@$(OS) --format=berkeley $<
	
%.o: %.c
	@echo
	@echo Compiling: $<
	$(CC) -c $(CFLAGS) $(DEFS) $(INCLUDE) -I. $< -o $@

%.o: %.S
	@echo
	@echo Assembling: $<
	$(CC) -x assembler-with-cpp -c $(ASFLAGS) $< -o $@	

clean: 
	@echo Cleaning:
	$(RM) $(OBJS)
	$(RM) *.elf
	$(RM) *.lst
	$(RM) *.map
	$(RM) *.bin
	$(RM) *.hex
