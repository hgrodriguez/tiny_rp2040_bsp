with RP.Device;

with Tiny;

procedure LEDs is

   Delay_In_Between : constant Integer := 1000;

begin
   Tiny.Initialize;
   loop
      --  LED Red
      RP.Device.Timer.Delay_Milliseconds (Delay_In_Between);
      Tiny.Switch_On (Tiny.LED_Red);
      RP.Device.Timer.Delay_Milliseconds (Delay_In_Between);
      Tiny.Switch_Off (Tiny.LED_Red);

      --  LED Green
      RP.Device.Timer.Delay_Milliseconds (Delay_In_Between);
      Tiny.Switch_On (Tiny.LED_Green);
      RP.Device.Timer.Delay_Milliseconds (Delay_In_Between);
      Tiny.Switch_Off (Tiny.LED_Green);

      --  LED Blue
      RP.Device.Timer.Delay_Milliseconds (Delay_In_Between);
      Tiny.Switch_On (Tiny.LED_Blue);
      RP.Device.Timer.Delay_Milliseconds (Delay_In_Between);
      Tiny.Switch_Off (Tiny.LED_Blue);
   end loop;
end LEDs;
