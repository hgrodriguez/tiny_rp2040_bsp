--===========================================================================
--
--  This package is the implementation
--    for the Tiny RP2040 board
--
--===========================================================================
--
--  Copyright 2022 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Clock;
with RP.Device;

package body Tiny is

   ------------------------------------------------------
   --  see .ads
   procedure Initialize is
   begin
      RP.Clock.Initialize (Tiny.XOSC_Frequency);
      RP.Clock.Enable (RP.Clock.PERI);
      RP.Device.Timer.Enable;

      --  configure the LEDs on the board
      --  I am sure, that 99% of users want it this way
      Tiny.LED_Red.Configure (RP.GPIO.Output);
      Tiny.LED_Green.Configure (RP.GPIO.Output);
      Tiny.LED_Blue.Configure (RP.GPIO.Output);

      Tiny.Switch_Off (Tiny.LED_Red);
      Tiny.Switch_Off (Tiny.LED_Green);
      Tiny.Switch_Off (Tiny.LED_Blue);
   end Initialize;

   ------------------------------------------------------
   --  see .ads
   procedure Switch_On (This : in out RP.GPIO.GPIO_Point) is
   begin
      This.Clear;
   end Switch_On;

   ------------------------------------------------------
   --  see .ads
   procedure Switch_Off (This : in out RP.GPIO.GPIO_Point) is
   begin
      This.Set;
   end Switch_Off;

   ------------------------------------------------------
   --  see .ads
   procedure Toggle (This : in out RP.GPIO.GPIO_Point) is
   begin
      if This.Get then
         Switch_On (This => This);
      else
         Switch_Off (This => This);
      end if;
   end Toggle;

end Tiny;
