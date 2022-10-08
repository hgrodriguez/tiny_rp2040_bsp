--===========================================================================
--
--  This package represents the definitions for
--    all ports
--    all standard definitions
--    for the Tiny RP2040 board
--
--===========================================================================
--
--  Copyright 2022 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.GPIO;
with RP.I2C_Master;
with RP.Device;
with RP.Clock;
with RP.UART;
with RP.SPI;

package Tiny is

   --------------------------------------------------------------------------
   --  Just the list of all GPIO pins for the RP2040 chip
   --  The commented lines do not have a board connection
   --------------------------------------------------------------------------
   GP0  : aliased RP.GPIO.GPIO_Point := (Pin => 0);
   GP1  : aliased RP.GPIO.GPIO_Point := (Pin => 1);
   GP2  : aliased RP.GPIO.GPIO_Point := (Pin => 2);
   GP3  : aliased RP.GPIO.GPIO_Point := (Pin => 3);
   GP4  : aliased RP.GPIO.GPIO_Point := (Pin => 4);
   GP5  : aliased RP.GPIO.GPIO_Point := (Pin => 5);
   GP6  : aliased RP.GPIO.GPIO_Point := (Pin => 6);
   GP7  : aliased RP.GPIO.GPIO_Point := (Pin => 7);
   --  GP8  : aliased RP.GPIO.GPIO_Point := (Pin => 8);
   --  GP9  : aliased RP.GPIO.GPIO_Point := (Pin => 9);
   --  GP10 : aliased RP.GPIO.GPIO_Point := (Pin => 10);
   --  GP11 : aliased RP.GPIO.GPIO_Point := (Pin => 11);
   --  GP12 : aliased RP.GPIO.GPIO_Point := (Pin => 12);
   --  GP13 : aliased RP.GPIO.GPIO_Point := (Pin => 13);
   --  GP14 : aliased RP.GPIO.GPIO_Point := (Pin => 14);
   --  GP15 : aliased RP.GPIO.GPIO_Point := (Pin => 15);
   --  GP16 : aliased RP.GPIO.GPIO_Point := (Pin => 16);
   --  GP17 : aliased RP.GPIO.GPIO_Point := (Pin => 17);
   GP18 : aliased RP.GPIO.GPIO_Point := (Pin => 18);
   GP19 : aliased RP.GPIO.GPIO_Point := (Pin => 19);
   GP20 : aliased RP.GPIO.GPIO_Point := (Pin => 20);
   --  GP21 : aliased RP.GPIO.GPIO_Point := (Pin => 21);
   --  GP22 : aliased RP.GPIO.GPIO_Point := (Pin => 22);
   GP23 : aliased RP.GPIO.GPIO_Point := (Pin => 23);
   --  GP24 : aliased RP.GPIO.GPIO_Point := (Pin => 24);
   --  GP25 : aliased RP.GPIO.GPIO_Point := (Pin => 25);
   GP26 : aliased RP.GPIO.GPIO_Point := (Pin => 26);
   GP27 : aliased RP.GPIO.GPIO_Point := (Pin => 27);
   GP28 : aliased RP.GPIO.GPIO_Point := (Pin => 28);
   GP29 : aliased RP.GPIO.GPIO_Point := (Pin => 29);

   --------------------------------------------------------------------------
   --  Order is counter clockwise around the chip,
   --  if you look at it holding the USB port top
   --  the identifiers are the ones on the board
   --------------------------------------------------------------------------

   --------------------------------------------------------------------------
   --  Left row of pins
   --------------------------------------------------------------------------
   ADC3     : aliased RP.GPIO.GPIO_Point := GP29;
   ADC2     : aliased RP.GPIO.GPIO_Point := GP28;
   ADC1     : aliased RP.GPIO.GPIO_Point := GP27;
   ADC0     : aliased RP.GPIO.GPIO_Point := GP26;
   --  I2C block, device 1
   SCL_1_27 : aliased RP.GPIO.GPIO_Point := GP27;
   SDA_1_26 : aliased RP.GPIO.GPIO_Point := GP26;

   --------------------------------------------------------------------------
   --  Right row of pins
   --------------------------------------------------------------------------
   --  UART block, device 1
   RX_1   : aliased RP.GPIO.GPIO_Point := GP5;
   TX_1   : aliased RP.GPIO.GPIO_Point := GP4;
   --  UART block, device 0
   RX_0   : aliased RP.GPIO.GPIO_Point := GP1;
   TX_0   : aliased RP.GPIO.GPIO_Point := GP0;
   --------------------------------------------------------------------------
   --  I2C block, device 1
   SCL_1_7 : aliased RP.GPIO.GPIO_Point := GP7;
   SDA_1_6 : aliased RP.GPIO.GPIO_Point := GP6;
   --  I2C block, device 0
   SCL_0_5 : aliased RP.GPIO.GPIO_Point := GP5;
   SDA_0_4 : aliased RP.GPIO.GPIO_Point := GP4;
   --  I2C block, device 1
   SCL_1_3 : aliased RP.GPIO.GPIO_Point := GP3;
   SDA_1_2 : aliased RP.GPIO.GPIO_Point := GP2;
   --  I2C block, device 0
   SCL_0_1 : aliased RP.GPIO.GPIO_Point := GP1;
   SDA_0_0 : aliased RP.GPIO.GPIO_Point := GP0;
   --------------------------------------------------------------------------
   --  SPI block: there is only one SPI port available
   --  this can be mapped to
   --  either GP7 - GP4
   MOSI_0_7    : RP.GPIO.GPIO_Point renames Tiny.GP7;
   SCK_0_6     : RP.GPIO.GPIO_Point renames Tiny.GP6;
   NSS_0_5     : RP.GPIO.GPIO_Point renames Tiny.GP5;
   MISO_0_4    : RP.GPIO.GPIO_Point renames Tiny.GP4;
   --  or GP3 - GP0
   MOSI_0_3    : RP.GPIO.GPIO_Point renames Tiny.GP3;
   SCK_0_2   : RP.GPIO.GPIO_Point renames Tiny.GP2;
   NSS_0_1   : RP.GPIO.GPIO_Point renames Tiny.GP1;
   MISO_0_0  : RP.GPIO.GPIO_Point renames Tiny.GP0;

   --------------------------------------------------------------------------
   --  LEDs RGB
   --  IMPORTANT: those LEDs are active *LOW*
   --          => .Clear will switch the LED *ON*
   --------------------------------------------------------------------------
   LED_Red     : aliased RP.GPIO.GPIO_Point := GP18;
   LED_Green : aliased RP.GPIO.GPIO_Point := GP19;
   LED_Blue  : aliased RP.GPIO.GPIO_Point := GP20;

   --------------------------------------------------------------------------
   --  System frequency
   XOSC_Frequency : RP.Clock.XOSC_Hertz := 12_000_000;

   --------------------------------------------------------------------------
   --  just convenient definitions for the ports
   SPI    : RP.SPI.SPI_Port renames RP.Device.SPI_0;
   I2C_0  : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2CM_0;
   I2C_1  : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2CM_1;
   UART_0 : RP.UART.UART_Port renames RP.Device.UART_0;
   UART_1 : RP.UART.UART_Port renames RP.Device.UART_1;

   ------------------------------------------------------
   --  Do the basic initialization
   procedure Initialize;

   ------------------------------------------------------
   --  Switch on This LED
   procedure Switch_On (This : in out RP.GPIO.GPIO_Point);

   ------------------------------------------------------
   --  Switch off This LED
   procedure Switch_Off (This : in out RP.GPIO.GPIO_Point);

   ------------------------------------------------------
   --  Toggle This LED
   procedure Toggle (This : in out RP.GPIO.GPIO_Point);

end Tiny;
