with HAL;
with HAL.UART;

with RP.Device;
with RP.GPIO;
with RP.UART;

with Tiny;

procedure UART is
   --------------------------------------------------------------------------
   --  Definitions of the UART ports to use for the communication.
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
   --  UART 0
   UART_0    : RP.UART.UART_Port renames Tiny.UART_0;
   TX_0 : RP.GPIO.GPIO_Point renames Tiny.TX_0;
   RX_0 : RP.GPIO.GPIO_Point renames Tiny.RX_0;

   --------------------------------------------------------------------------
   --  UART 1
   UART_1    : RP.UART.UART_Port renames Tiny.UART_1;
   TX_1 : RP.GPIO.GPIO_Point renames Tiny.TX_1;
   RX_1 : RP.GPIO.GPIO_Point renames Tiny.RX_1;

   --------------------------------------------------------------------------
   --  Selection of UART to use
   UART    : RP.UART.UART_Port renames UART_0;
   TX : RP.GPIO.GPIO_Point renames TX_0;
   RX : RP.GPIO.GPIO_Point renames RX_0;

   procedure UART_Initialize is
   begin
      TX.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.UART);
      RX.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.UART);
      UART.Configure
        (Config =>
           (Baud      => 9_600,
            Word_Size => 8,
            Parity    => False,
            Stop_Bits => 1,
            others    => <>));
   end UART_Initialize;

   Status        : HAL.UART.UART_Status;
   Data_Out      : HAL.UART.UART_Data_8b (1 .. 1);
   Data_In       : HAL.UART.UART_Data_8b (1 .. 1);

begin
   Tiny.Initialize;

   UART_Initialize;
   UART.Send_Break (RP.Device.Timer'Access, UART.Frame_Time * 2);

   loop
      for Byte in HAL.UInt8'Range loop
         Data_Out (1) := Byte;
         UART.Transmit (Data_Out, Status);
         UART.Receive (Data_In, Status, 0);
         Tiny.LED_Red.Toggle;
      end loop;
   end loop;
end UART;
