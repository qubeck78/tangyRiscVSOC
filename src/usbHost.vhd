library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;



entity usbHost is

port(

   --cpu interface
   reset:            in    std_logic;
   clock:            in    std_logic;
   a:                in    std_logic_vector( 15 downto 0 );
   din:              in    std_logic_vector( 31 downto 0 );
   dout:             out   std_logic_vector( 31 downto 0 );
   
   ce:               in    std_logic;
   wr:               in    std_logic;
   dataMask:         in    std_logic_vector( 3 downto 0 );
   
   ready:            out   std_logic;
   
   --usb clock (12MHz)
   usbHClk:          in    std_logic;
   
   --usb interfaces
   usbH0Dp:          inout std_logic;     
   usbH0Dm:          inout std_logic      

);
end usbHost;


architecture behavior of usbHost is

-- components

-- usb hid host
component usb_hid_host is
port(
    usbclk:         in std_logic;                       --12MHz clock
    usbrst_n:       in std_logic;                       --reset
    usb_dm:         inout std_logic; 
    usb_dp:         inout std_logic;                    --USB D- and D+
    typ:            out std_logic_vector( 1 downto 0 ); --device type. 0: no device, 1: keyboard, 2: mouse, 3: gamepad
    
    reportPulse:    out std_logic;                      --pulse after report received from device. 
                                                        --key_*, mouse_*, game_* valid depending on typ
    conerr:         out std_logic;                      --connection or protocol error

    --keyboard
    key_modifiers:  out std_logic_vector( 7 downto 0 );
    key1:           out std_logic_vector( 7 downto 0 );
    key2:           out std_logic_vector( 7 downto 0 );
    key3:           out std_logic_vector( 7 downto 0 );
    key4:           out std_logic_vector( 7 downto 0 );

    --mouse
    mouse_btn:      out std_logic_vector( 7 downto 0 ); --{5'bx, middle, right, left}
    mouse_dx:       out std_logic_vector( 7 downto 0 ); --signed 8-bit, cleared after `report` pulse
    mouse_dy:       out std_logic_vector( 7 downto 0 ); --signed 8-bit, cleared after `report` pulse

    --gamepad 
    game_l:         out std_logic;
    game_r:         out std_logic;
    game_u:         out std_logic;
    game_d:         out std_logic;                      --left right up down
    game_a:         out std_logic;
    game_b:         out std_logic;
    game_x:         out std_logic;
    game_y:         out std_logic;
    game_sel:       out std_logic;
    game_sta:       out std_logic;                      --buttons

    --debug
    dbg_hid_report: out std_logic_vector( 63 downto 0 ) --last HID report
);
end component; 

-- usb hid keyboard data fifo
--component keyboardFifo IS
--   PORT
--   (
--      data        : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
--      rdclk       : IN STD_LOGIC ;
--      rdreq       : IN STD_LOGIC ;
--      wrclk       : IN STD_LOGIC ;
--      wrreq       : IN STD_LOGIC ;
--      q           : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
--      rdempty     : OUT STD_LOGIC ;
--      wrfull      : OUT STD_LOGIC 
--   );
--END component;

component keyboardFifo
	port (
		Data: in std_logic_vector(31 downto 0);
		WrClk: in std_logic;
		RdClk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Q: out std_logic_vector(31 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;

--signals

--registers signals
type usbhRegState_T is ( usbhrWaitForRegAccess, usbhrWaitForBusCycleEnd );
signal usbhRegState:       usbhRegState_T;

--usb host signals

signal usbH0Type:          std_logic_vector( 1 downto 0 );
signal usbH0ReportPulse:   std_logic;
signal usbH0KeyModifiers:  std_logic_vector( 7 downto 0 );
signal usbH0Key1:          std_logic_vector( 7 downto 0 );
signal usbH0Key2:          std_logic_vector( 7 downto 0 );
signal usbH0Key3:          std_logic_vector( 7 downto 0 );
signal usbH0Key4:          std_logic_vector( 7 downto 0 );
signal usbH0MouseBtn:      std_logic_vector( 7 downto 0 );
signal usbH0MouseDx:       std_logic_vector( 7 downto 0 );
signal usbH0MouseDy:       std_logic_vector( 7 downto 0 );
signal usbH0HidReport:     std_logic_vector( 63 downto 0 );

--keyboard fifo sync signals
type fifoHidKeyboardSyncState_T is ( fksIdle, fksWaitForPulseRelease );
signal fifoHidKeyboardSyncState: fifoHidKeyboardSyncState_T;

--keyboard fifo signals
signal fifoHidKeyboardRdEn:     std_logic;
signal fifoHidKeyboardWrEn:     std_logic;
signal fifoHidKeyboardDataOut:  std_logic_vector( 31 downto 0 );
signal fifoHidKeyboardDataIn:   std_logic_vector( 31 downto 0 );
signal fifoHidKeyboardEmpty:    std_logic;
signal fifoHidKeyboardFull:     std_logic; 

begin

registers: process( all )
   begin

      if rising_edge( clock ) then
      
         if reset = '1' then
         
            fifoHidKeyboardRdEn  <= '0';

            ready <= '0';  
            usbhRegState   <= usbhrWaitForRegAccess;           
            
         else
         
         
            fifoHidKeyboardRdEn  <= '0';
            
            case usbhRegState is
      
               when usbhrWaitForRegAccess =>
            
                  if ce = '1' then
                  
                     --cpu wants to access registers
                  
                     ready <= '0';
                     
                     case a( 7 downto 0 ) is
                     
                        --0x00 r- usbHidKeyboardStatus                     
                        when x"00" =>
                        
                           dout <= x"0000000" & "00" & fifoHidKeyboardFull & fifoHidKeyboardEmpty;

                           ready <= '1';

                        --0x04 r- usbHidKeyboardData                    
                        when x"01" =>
                        
                           dout                 <= fifoHidKeyboardDataOut;
                           fifoHidKeyboardRdEn  <= '1'; 

                           ready                <= '1';                       
                        
                        when others =>
                        
                           dout  <= ( others => '0' );
                           ready <= '1';
                           
                     end case; -- a( 7 downto 0 ) is
                     
                     usbhRegState <= usbhrWaitForBusCycleEnd;
                  
                  end if; -- ce = '1';
                  
               when usbhrWaitForBusCycleEnd =>
               
                  --wait for bus cycle to end
                  if ce = '0' then
                  
                     usbhRegState <= usbhrWaitForRegAccess;
                     ready <= '0';
                     
                  end if;
                  
               when others =>
               
                  usbhRegState <= usbhrWaitForRegAccess;
                  
            end case; --usbhRegState is

         end if; --reset = '1'
   
      end if;--rising_edge( clock )
         
   end process;
      
      
--usb keyboard fifo sync process
fifoHidKeyboardSync: process( all )
begin
    if rising_edge( clock ) then

        if reset = '1' then

            fifoHidKeyboardWrEn         <= '0';
            fifoHidKeyboardDataIn       <= ( others => '0' );
            fifoHidKeyboardSyncState    <= fksIdle;
        else
            

            case fifoHidKeyboardSyncState is

                when fksIdle =>
                    
                    fifoHidKeyboardWrEn         <= '0';

                    fifoHidKeyboardDataIn       <= usbH0KeyModifiers & usbH0Key3 & usbH0Key2 & usbH0Key1;

                    if usbH0ReportPulse = '1' and usbH0Type = "01" then
                        fifoHidKeyboardSyncState  <= fksWaitForPulseRelease;
                        fifoHidKeyboardWrEn       <= '1';
                    end if;

                when fksWaitForPulseRelease =>

                    fifoHidKeyboardWrEn         <= '0';

                    if usbH0ReportPulse = '0' then
                        fifoHidKeyboardSyncState  <= fksIdle;
                    end if;
               
               when others =>
                  
                  fifoHidKeyboardSyncState  <= fksIdle;
            
            end case;

        end if;

    end if;

end process;  

-- place usb host0
usb_hid_host0Inst:usb_hid_host
port map(
    usbclk          => usbHClk,
    usbrst_n        => not reset,
    usb_dm          => usbH0Dm, 
    usb_dp          => usbh0Dp,
    typ             => usbH0Type,
    
    reportPulse     => usbH0ReportPulse,
    --conerr:         out std_logic;                      --connection or protocol error

    --keyboard
    key_modifiers   => usbH0KeyModifiers,
    key1            => usbH0Key1,
    key2            => usbH0Key2,
    key3            => usbH0Key3,
    key4            => usbH0Key4,

    --mouse
    mouse_btn       => usbH0MouseBtn,
    mouse_dx        => usbH0MouseDx,
    mouse_dy        => usbH0MouseDy,

    --debug
    dbg_hid_report  => usbH0HidReport
);


--place keyboard fifo
--keyboardFifoInst:keyboardFifo
--port map(

--      wrclk       => clock,
--      wrreq       => fifoHidKeyboardWrEn,
--      data        => fifoHidKeyboardDataIn,
--      
--      
--      rdclk       => clock,
--      rdreq       => fifoHidKeyboardRdEn,
--      q           => fifoHidKeyboardDataOut,

--      rdempty     => fifoHidKeyboardEmpty,
--      wrfull      => fifoHidKeyboardFull
--      
--);

keyboardFifoInst:keyboardFifo
port map(
		WrClk   => clock,
		WrEn    => fifoHidKeyboardWrEn,
		Data    => fifoHidKeyboardDataIn,

		RdClk   => clock,
		RdEn    => fifoHidKeyboardRdEn,
		Q       => fifoHidKeyboardDataOut,
		Empty   => fifoHidKeyboardEmpty,
		Full    => fifoHidKeyboardFull
);


end behavior;
