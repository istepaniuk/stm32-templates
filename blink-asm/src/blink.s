.section .vectors
.org 0
.word 0x20000400             /* initial stack pointer   */
                             /* exception vector table  */
.word poweron+1              /* reset vector */
.word unhandled+1            /* NMI          */
.word unhandled+1            /* hard fault   */
.word unhandled+1            /* mm fault     */
.word unhandled+1            /* bus fault    */
.word unhandled+1            /* usage fault  */
.word unhandled+1            /* reserved */
.word unhandled+1            /* reserved */
.word unhandled+1            /* reserved */
.word unhandled+1            /* reserved */
.word unhandled+1            /* SVC      */
.word unhandled+1            /* debug    */
.word unhandled+1            /* reserved */
.word unhandled+1            /* PendSV   */
.word unhandled+1            /* systick  */
.word unhandled+1            /* IRQ0   */
.word unhandled+1            /* IRQ1   */
.word unhandled+1            /* IRQ2   */
.word unhandled+1            /* IRQ3   */
.word unhandled+1            /* IRQ4   */
.word unhandled+1            /* IRQ5   */
.word unhandled+1            /* IRQ6   */
.word unhandled+1            /* IRQ7   */
.word unhandled+1            /* IRQ8   */
.word unhandled+1            /* IRQ9   */
.word unhandled+1            /* IRQ10  */
.word unhandled+1            /* IRQ11  */
.word unhandled+1            /* IRQ12  */
.word unhandled+1            /* IRQ13  */
.word unhandled+1            /* IRQ14  */
.word unhandled+1            /* IRQ15  */
.word unhandled+1            /* IRQ16  */
.word unhandled+1            /* IRQ17  */
.word unhandled+1            /* IRQ18  */
.word unhandled+1            /* IRQ19  */
.word unhandled+1            /* IRQ20  */
.word unhandled+1            /* IRQ21  */
.word unhandled+1            /* IRQ22  */
.word unhandled+1            /* IRQ23  */
.word unhandled+1            /* IRQ24  */
.word unhandled+1            /* IRQ25  */
.word unhandled+1            /* IRQ26  */
.word unhandled+1            /* IRQ27  */
.word unhandled+1            /* IRQ28  */
.word unhandled+1            /* IRQ29  */
.word unhandled+1            /* IRQ30  */
.word unhandled+1            /* IRQ31  */
.word unhandled+1            /* IRQ32  */
.word unhandled+1            /* IRQ33  */
.word unhandled+1            /* IRQ34  */
.word unhandled+1            /* IRQ35  */
.word unhandled+1            /* IRQ36  */
.word unhandled+1            /* IRQ37  */
.word unhandled+1            /* IRQ38  */
.word unhandled+1            /* IRQ39  */
.word unhandled+1            /* IRQ40  */
.word unhandled+1            /* IRQ41  */
.word unhandled+1            /* IRQ42  */
.word unhandled+1            /* IRQ43  */
.word unhandled+1            /* IRQ44  */
.word unhandled+1            /* IRQ45  */
.word unhandled+1            /* IRQ46  */
.word unhandled+1            /* IRQ47  */
.word unhandled+1            /* IRQ48  */
.word unhandled+1            /* IRQ49  */
.word unhandled+1            /* IRQ50  */
.word unhandled+1            /* IRQ51  */
.word unhandled+1            /* IRQ52  */
.word unhandled+1            /* IRQ53  */
.word unhandled+1            /* IRQ54  */
.word unhandled+1            /* IRQ55  */
.word unhandled+1            /* IRQ56  */
.word unhandled+1            /* IRQ57  */
.word unhandled+1            /* IRQ58  */
.word unhandled+1            /* IRQ59  */
.word unhandled+1            /* IRQ60  */
.word unhandled+1            /* IRQ61  */
.word unhandled+1            /* IRQ62  */
.word unhandled+1            /* IRQ63  */
.word unhandled+1            /* IRQ64  */
.word unhandled+1            /* IRQ65  */
.word unhandled+1            /* IRQ66  */
.word unhandled+1            /* IRQ67  */

.text
.align 2

    .word 0,0,0,0,0
poweron:
    bl external_clock

    /* enable GPIO C clock */
    ldr r0,=0x40021000        /* RCC: Reset/Clock Control */
    ldr r1,[r0,#0x18]         /* APB2ENR: peripheral clock enable */
    mov r2,#0x10
    orr r1,r2                 /* bit 4: IOPC EN (GPIO C) */
    str r1,[r0,#0x18]

    /* set LED pins as outputs */
    ldr r0,=0x40011000        /* GPIO C */
    ldr r1,=0x44444441        /* pins 8 and 9 out, rest float in */
    str r1,[r0,#4]            /* high control reg (pins 8-16) */
loop:
    ldr r1,=0x00000300
    str r1,[r0,#12]
    bl delay
    ldr r1,=0x00000000
    str r1,[r0,#12]
    bl delay
    b loop
.ltorg

external_clock:
    /* Use HSE clock at 8MHz */
    ldr r0,=0x40021000        /* reset/clock control */

    /* Set RCC_CFGR to MCO=off, PLLMUL=3x, PLLSRC=prediv1, SW=PLL */
    ldr r1,=0x00050002
    str r1,[r0,#4]            /* RCC_CFGR */

    /* Set RCC_CR.HSEON and set RCC_CR.PLLON */
    ldr r1,[r0,#0]            /* RCC_CR */
    ldr r2,=0x01010000        /* HSEON=bit 16, PLLON=bit 24 */
    orr r1,r2
    str r1,[r0,#0]

    bx lr
.ltorg

delay:
    ldr r2,=2500000
delay_loop:
    sub r2,r2,#1
    bne delay_loop
    bx lr
.ltorg

unhandled:
    bx lr
