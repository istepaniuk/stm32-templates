#include <stdio.h>
#include "stm32f10x_lib.h"
#include "arm_comm.h"
#include "usart.h"

// Type definition
USART_InitTypeDef USART_InitStructure;
GPIO_InitTypeDef GPIO_InitStructure;

void InitUSART2(void) {

  // Enable clocks
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART2, ENABLE);

  USART_Cmd(USART2, ENABLE);

  // Gonfigure UART2_Tx pin PA2
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
  GPIO_Init (GPIOA, &GPIO_InitStructure);

  // Gonfigure UART2_Rx pin PA3
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPD ;
  GPIO_Init (GPIOA, &GPIO_InitStructure);


  USART_StructInit(&USART_InitStructure);
  USART_InitStructure.USART_WordLength = USART_WordLength_8b;
  USART_InitStructure.USART_StopBits = USART_StopBits_1;
  USART_InitStructure.USART_Parity = USART_Parity_No ;
  USART_InitStructure.USART_BaudRate = 115200;
  USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
  USART_InitStructure.USART_Mode = (USART_Mode_Tx|USART_Mode_Rx);


  USART_Init(USART2, &USART_InitStructure);

}

void InitUSART3(void) {

   // Enable clocks
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3, ENABLE);

  USART_Cmd(USART3, ENABLE);

  // Gonfigure UART2_Tx pin PA2
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
  GPIO_Init (GPIOC, &GPIO_InitStructure);

  // Gonfigure UART2_Rx pin PA3
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPD ;
  GPIO_Init (GPIOC, &GPIO_InitStructure);


  USART_StructInit(&USART_InitStructure);
  USART_InitStructure.USART_WordLength = USART_WordLength_8b;
  USART_InitStructure.USART_StopBits = USART_StopBits_1;
  USART_InitStructure.USART_Parity = USART_Parity_No ;
  USART_InitStructure.USART_BaudRate = 115200;
  USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
  USART_InitStructure.USART_Mode = (USART_Mode_Tx|USART_Mode_Rx);

  // Remap :-)
  AFIO->MAPR |= 0x00000010;

  USART_Init(USART3, &USART_InitStructure);

}

void Uart2SendChar(Int8U c) {

  while(USART_GetFlagStatus(USART2, USART_FLAG_TXE) == RESET);
  USART_SendData(USART2, c);
}

void Uart3SendChar(Int8U c) {

  while(USART_GetFlagStatus(USART3, USART_FLAG_TXE) == RESET);
  USART_SendData(USART3, c);
}

Int8U Uart2ReadChar(void) {

  while(USART_GetFlagStatus(USART2, USART_FLAG_RXNE) == RESET);
  return USART_ReceiveData(USART2);
}

Int8U Uart3ReadChar(void) {

  while(USART_GetFlagStatus(USART3, USART_FLAG_RXNE) == RESET);
  return USART_ReceiveData(USART3);
}

void Uart2WriteStr(Int8U* s) {
  char i=0;
  while(s[i]!=0) {
    Uart2SendChar(s[i]);
    i++;
  }
}

void Uart3WriteStr(Int8U* s) {

  char i=0;
  while(s[i]!=0) {
    Uart3SendChar(s[i]);
    i++;
  }
}
