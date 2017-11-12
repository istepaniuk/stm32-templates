STM32 Blink Templates
=====================

It is difficult to start developing for embedded devices in a new environment and in an unknown platform, I consider the propietary IDEs for embedded ARM development to be horribly bloated, and in most cases they only support Microsoft Windows.

These are three working "blinking led" examples for the STM32F1XX embedded ARM Cortex-M3 Discovery evaluation board. Starting from these working examples it should be easier to extend them into real embeded applications, using the GNU toolchain, under GNU/Linux, with your favorite, or without any IDE. Awesome.

In the root directory you will find a cross-compiling toolchain targeting ARM, that should work on any x86 Linux system. The toolchain was copied from CodeSourcery, any standard toolchain should work provided that you update the paths in the Makefiles. All makefiles reference to this toolchain.

The repo contains three versions of the classical blinking led example:

## blink-asm
Minimalistic approach, just an ARM assembler source, linker script and a Makefile.

## blink-plain
Plain C approach, the simplest C source code, linker script and a Makefile. 
TODO: Note that this can be further stripped down, it is still using the startup code from the CMSIS version, but not the complete libraries.

## blink-cmsis
C approach using the CMSIS (Cortex™ Microcontroller Software Interface Standard) common libraries and the ST libraries for the STM32F1XX part. As the other examples, it also contains a linker script and a Makefile that should just work.

## Flashing, running!
* You will need to setup and run `st-util` from texane's stlink, follow the instructions [here](https://github.com/texane/stlink)
* Running `make` on each blink-* directory should compile and create a binary `.elf`, ready to be loaded.
* In all three examples, there is a `load` bash script that contains the gdb commands to flash the `.elf` into the connected device.
* The `target extended-remote :4242` command in the `load` script connects to your local port 4242, the default port in which st-util will listen to, so st-util has to be running.

* All these examples work in the Discovery 32VL board, containing the STM32F100 Medium Density VL (pictured), using the v1 version of the st-link protocol (I run st-util like `./st-util -1`)

![Discovery 32VL](http://blog.istepaniuk.com/wp-content/uploads/discovery.jpg)
