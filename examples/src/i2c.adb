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
with HAL.I2C;

with RP.GPIO;
with RP.I2C_Master;
with RP.Device;

with Tiny;

procedure I2C is

   --------------------------------------------------------------------------
   --  I2C 0
   I2C_0 : RP.I2C_Master.I2C_Master_Port renames Tiny.I2C_0;
   SCL_0 : RP.GPIO.GPIO_Point renames Tiny.SCL_0_1;
   SDA_0 : RP.GPIO.GPIO_Point renames Tiny.SDA_0_0;

   --------------------------------------------------------------------------
   --  I2C 1
   I2C_1 : RP.I2C_Master.I2C_Master_Port renames Tiny.I2C_1;
   SCL_1 : RP.GPIO.GPIO_Point renames Tiny.SCL_1_3;
   SDA_1 : RP.GPIO.GPIO_Point renames Tiny.SDA_1_2;

   --------------------------------------------------------------------------
   --  Selection of I2C to use
   I2C : RP.I2C_Master.I2C_Master_Port renames I2C_0;
   SCL : RP.GPIO.GPIO_Point renames SCL_0;
   SDA : RP.GPIO.GPIO_Point renames SDA_0;

   --------------------------------------------------------------------------
   --  Definition of trigger port
   Trigger : RP.GPIO.GPIO_Point renames Tiny.GP7;

   procedure I2C_Initialize is
   begin
      SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      I2C.Configure (Baudrate => 100_000);
   end I2C_Initialize;

   Address : constant HAL.I2C.I2C_Address := 16#5A#;
   Data    : HAL.I2C.I2C_Data (1 .. 1);
   Status  : HAL.I2C.I2C_Status;

begin
   Tiny.Initialize;

   I2C_Initialize;

   Trigger.Configure (RP.GPIO.Output);

   loop
      --  construct the values for the transmission
      for Byte in HAL.UInt8'Range loop
         Data (1) := Byte;
         Data (1) := 16#55#;
         Trigger.Clear;
         if True then
            I2C.Master_Transmit (Addr    => Address,
                                 Data    => Data,
                                 Status  => Status,
                                 Timeout => 0);
         else
            I2C.Mem_Write (Addr          => Address,
                           Mem_Addr      => 16#55#,
                           Mem_Addr_Size => HAL.I2C.Memory_Size_8b,
                           Data          => Data,
                           Status        => Status,
                           Timeout       => 0);
         end if;

         Trigger.Set;
         --         RP.Device.Timer.Delay_Milliseconds (10);
         Tiny.LED_Red.Toggle;
      end loop;
   end loop;

end I2C;
