// usart.h

#ifndef __STM32F_USART
#define __STM32F_USART

#include "arm_comm.h"

void InitUSART2(void);
void InitUSART3(void);

void Uart2SendChar(Int8U c);
void Uart3SendChar(Int8U c);

Int8U Uart2ReadChar(void);
Int8U Uart3ReadChar(void);

void Uart2WriteStr(Int8U* s);
void Uart3WriteStr(Int8U* s);

#endif


