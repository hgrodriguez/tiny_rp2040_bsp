--===========================================================================
--
--  This is the main master program for the Tiny as an SPI Master
--
--===========================================================================
--
--  Copyright 2022 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL;
with HAL.SPI;

with RP.GPIO;
with RP.SPI;
with RP.Device;

with Tiny;

procedure SPI_Master_16 is
   Data_Out_16   : HAL.SPI.SPI_Data_16b (1 .. 1);
   Status_Out    : HAL.SPI.SPI_Status;

   Data_In_16 : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In  : HAL.SPI.SPI_Status;

   Word : HAL.UInt16;

   use HAL;
   use HAL.SPI;
   use RP.SPI;

   -----------------------------------------------------------------------
   SPI  : RP.SPI.SPI_Port renames Tiny.SPI;

   --  Master section 0
   SCK_0  : RP.GPIO.GPIO_Point renames Tiny.SCK_0_2;
   NSS_0  : RP.GPIO.GPIO_Point renames Tiny.NSS_0_1;
   MOSI_0 : RP.GPIO.GPIO_Point renames Tiny.MOSI_0_3;
   MISO_0 : RP.GPIO.GPIO_Point renames Tiny.MISO_0_0;

   --  Master section 1
   SCK_1  : RP.GPIO.GPIO_Point renames Tiny.SCK_0_6;
   NSS_1  : RP.GPIO.GPIO_Point renames Tiny.NSS_0_5;
   MOSI_1 : RP.GPIO.GPIO_Point renames Tiny.MOSI_0_7;
   MISO_1 : RP.GPIO.GPIO_Point renames Tiny.MISO_0_4;

   -----------------------------------------------------------------------
   --  Renaming section
   SCK  : RP.GPIO.GPIO_Point renames SCK_1;
   NSS  : RP.GPIO.GPIO_Point renames NSS_1;
   MOSI : RP.GPIO.GPIO_Point renames MOSI_1;
   MISO : RP.GPIO.GPIO_Point renames MISO_1;

   -----------------------------------------------------------------------
   --  Configuration for the master part for the Tiny
   Config          : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Master,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   -----------------------------------------------------------------------
   --  Initializes the Tiny as master SPI
   procedure SPI_Initialize is
   begin
      SCK.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      NSS.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      MOSI.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      MISO.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.SPI);

      SPI.Configure (Config);
   end SPI_Initialize;

begin
   Tiny.Initialize;

   SPI_Initialize;

   loop
      --  construct the values for the transmission
      for Higher_Byte in HAL.UInt8'Range loop
         for Lower_Byte in HAL.UInt8'Range loop
            Word := Shift_Left (Value  => HAL.UInt16 (Higher_Byte),
                                Amount => 8) or HAL.UInt16 (Lower_Byte);
            Data_Out_16 (1) := Word;
            SPI.Transmit (Data_Out_16, Status_Out);
            SPI.Receive (Data_In_16, Status_In, 0);
            RP.Device.Timer.Delay_Milliseconds (100);
            Tiny.LED_Red.Toggle;
         end loop;
      end loop;
   end loop;

end SPI_Master_16;
