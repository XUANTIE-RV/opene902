/*Copyright 2018-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#define VCUNT_SIM

#include "datatype.h"
#include "uart.h"
//#include "stdio.h"
#include "timer.h"

#ifdef VCUNT_SIM
#include "vtimer.h"
#endif 


t_ck_uart_device uart0 = {0xFFFF};

int Loop_Num = 0;

int main (void)
{
  unsigned int* src_addr = 0xc000;
  unsigned int* des_addr = 0xe000;
  int cp_size            = 0x1000/4;
  int i                  = 0;

  int current_time;
  long total_time = 0;
  
  // initial memory
  for(i=0;i<cp_size;i++)
  {
    *(src_addr) = i;
    src_addr++;
  }
  
  //config the interrupt controller
  ck_intc_init();
  Timer_Interrupt_Init();

  //--------------------------------------------------------
  // setup uart
  //--------------------------------------------------------
  t_ck_uart_cfig   uart_cfig;

  uart_cfig.baudrate = BAUD;       // any integer value is allowed
  uart_cfig.parity = PARITY_NONE;     // PARITY_NONE / PARITY_ODD / PARITY_EVEN
  uart_cfig.stopbit = STOPBIT_1;      // STOPBIT_1 / STOPBIT_2
  uart_cfig.wordsize = WORDSIZE_8;    // from WORDSIZE_5 to WORDSIZE_8
  uart_cfig.txmode = ENABLE;          // ENABLE or DISABLE

  // open UART device with id = 0 (UART0)
  ck_uart_open(&uart0, 0);

  // initialize uart using uart_cfig structure
  ck_uart_init(&uart0, &uart_cfig);

  //--------------------------------------------------------
  // start main memory copy
  //--------------------------------------------------------
  // memory copy

  static int array_old[1024];
  static int array_new[1024];
//  word_memset(array_old,0xffffffff,0x400); 
//  word_memcpy(array_new,array_old,0x400);
  start_timer();

#ifdef VCUNT_SIM
  int start_sec;
  int end_sec;
  start_sec = get_vtimer();
#endif 

  memset(array_old,0xffffffff,0x400); 
//  __memcpy_fast(array_new,array_old,0x400);

#ifdef VCUNT_SIM
  end_sec = get_vtimer();
  end_sec = end_sec - start_sec;
  printf ("\nVCUNT_SIM:Memory set from 0x0 to 0x400 cost %d CPU cycles!\n",end_sec);
  sim_end();
#else
  current_time = get_timer();
  stop_timer();
  total_time = Loop_Num * TIMER_PERIOD + TIMER_PERIOD - current_time;
  printf("\nMemory set for 1024 bytes has complete!\n");
  printf("Which cost %d system timer cycles\n",total_time);
#endif 
  while (ck_uart_status(&uart0));
  return 0;
}

