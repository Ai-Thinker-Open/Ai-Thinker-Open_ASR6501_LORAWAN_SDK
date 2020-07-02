/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/
#ifndef _ASR_BOARD_TEST_H
#define _ASR_BOARD_TEST_H
#include <stdbool.h>
#include <stdio.h>

//自定义软件版本号
#define SOFT_VERSION "V1.0.0"
#define PROTOCOL_TYPE "LoRaWAN-CN470"

bool LoRaTestSleep(uint8_t sleep_mode);
bool LoRaTestMcu(uint8_t mcu_mode);
bool LoRaTestRx(uint32_t freq, uint8_t dr);
bool LoRaTestTx(uint32_t freq, uint8_t dr, uint8_t pwr, uint8_t len);
bool LoRaTestRxs(uint32_t freq, uint8_t dr, uint8_t cr, uint8_t ldo);
bool LoRaTestTxcw(uint32_t freq, uint8_t pwr, uint8_t opt);
bool LoRaTestStdby(uint8_t stdby);

#endif
/* [] END OF FILE */
