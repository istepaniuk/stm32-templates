#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"

void delay(unsigned long delay)
{
    while(delay) delay--;
}

int main(void)
{
    // Enable GPIO clock
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);

    // Configure pin as output push-pull (LED)
    GPIO_InitTypeDef GPIO_InitStructure;
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_Init(GPIOC, &GPIO_InitStructure);

    while(1)
    {
        GPIOC->ODR ^= GPIO_Pin_8;
        delay(500000);
    }
}

void SystemInit(void)
{ 
  
}

