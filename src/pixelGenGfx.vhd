library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pixelGenGfx is

port(
   reset:            in  std_logic;
   pggClock:         in  std_logic;
   pggR:             out std_logic_vector( 7 downto 0 );
   pggG:             out std_logic_vector( 7 downto 0 );
   pggB:             out std_logic_vector( 7 downto 0 );

    --gfx buffer ram
   gfxBufRamDOut:    in  std_logic_vector( 31 downto 0 );
   gfxBufRamRdA:     out std_logic_vector( 8 downto 0 );

   --2 dma requests
   pggDMARequest:    out std_logic_vector( 1 downto 0 );
   
   --sync gen outputs
   pgVSync:          in  std_logic;
   pgHSync:          in  std_logic;
   pgDe:             in  std_logic;
   pgXCount:         in  std_logic_vector( 11 downto 0 );
   pgYCount:         in  std_logic_vector( 11 downto 0 );
   pgDeX:            in  std_logic;
   pgDeY:            in  std_logic;
   pgPreFetchLine:   in  std_logic;
   pgFetchEnable:    in  std_logic;
   
   -- 00 : 320x240x16
   -- 01 : 640x480x16
   pgVideoMode:      in  std_logic_vector( 1 downto 0 )
   
);

end pixelGenGfx;

architecture behavior of pixelGenGfx is

type pggState_T is ( m1pre0, m1pre1, m1pre2, m1pre3, m1pre4, m1pre5, m1pre6, m1p0, m1p1, m1p2, m1p3, m1post0, m1post1, m1post2, m1post3, m1hblank,
                     m2pre0, m2pre1, m2pre2, m2pre3, m2pre4, m2pre5, m2pre6, m2p0, m2p1, m2hblank
);

signal pggState:                 pggState_T;
signal pggGfxBufAddressCounter:  std_logic_vector( 8 downto 0 );
signal pggLineCounter:           std_logic_vector( 1 downto 0 );
signal pggPixelData:             std_logic_vector( 31 downto 0 );

begin


   main: process( all )

   begin
   
      if rising_edge( pggClock ) then

         if reset = '1' then

            pggState                <= m1pre0;
            pggGfxBufAddressCounter <= ( others => '0' );
            pggLineCounter          <= ( others => '0' );
            pggPixelData            <= ( others => '0' );            
            pggDMARequest           <= ( others => '0' );
            
         else
         
         
            case pggState is
            
               ----------------------------------------------
               --mode 1: 320x240x16
               --wait for fetch enable
               
               --7 prefetch states to match 8 clock cycles between fetch enable and display enable
               when m1pre0 =>             
               
                  pggR <= ( others => '0' );
                  pggG <= ( others => '0' );
                  pggB <= ( others => '0' );

                  
                  --pass dma request for first displayed line
                  if pgPreFetchLine = '1' then
                  
                     --fill lower line
                     
                     pggDMARequest  <= "01";

                     --clear line counter for doubling lo-res lines
                     pggLineCounter <= ( others => '0' );
                     
                  else
                  
                     pggDMARequest  <= "00";
                  
                  end if;
                  
               
                  if pgFetchEnable = '1' then
                    
                        --pre fetch first data
                        
                        --reset line buf address counter
                        pggGfxBufAddressCounter <= ( others => '0' );

                        pggState <= m1pre1;

                 end if;
               
                  --switch mode if necesary
                  if pgVideoMode = "01" then
                  
                     pggState <= m2pre0;
                     
                  end if;
               
               
               when m1pre1 =>
                  gfxBufRamRdA   <= pggLineCounter( 1 ) & pggGfxBufAddressCounter( 7 downto 0 );
                  
                  pggState <= m1pre2;
               
               when m1pre2 =>
                  
                  --dma requests
                  if pggLineCounter( 0 ) = '0' then
                  
                     if pggLineCounter( 1 ) = '0' then
                  
                        --display lower buffer half, fill upper
                     
                        pggDMARequest  <= "10";
                     
                     else
                     
                        --display upper buffer half, fill lower
                     
                        pggDMARequest  <= "01";
                     
                     end if;
                  
                  end if;
                  
                  pggState <= m1pre3;
                  
               when m1pre3 =>
               
                  pggPixelData   <= gfxBufRamDOut;
                  pggGfxBufAddressCounter <= pggGfxBufAddressCounter + 1;
                  
                  pggState <= m1pre4;
                  
               when m1pre4 =>
               
                  --clear dma request
                  pggDMARequest  <= ( others => '0' );
               
                  pggState <= m1pre5;
               
               when m1pre5 =>
               
                  pggState <= m1pre6;
                  
               when m1pre6 =>
               
               
                  pggState <= m1p0;
                  
               when m1p0 =>

                  pggR     <= pggPixelData( 15 downto 11 ) & "000";
                  pggG     <= pggPixelData( 10 downto 5  ) & "00";                  
                  pggB     <= pggPixelData( 4  downto 0  ) & "000";
               
                  gfxBufRamRdA   <= pggLineCounter( 1 ) & pggGfxBufAddressCounter( 7 downto 0 );
                  
                  pggState <= m1p1;
                  
               when m1p1 =>
               
                  pggGfxBufAddressCounter <= pggGfxBufAddressCounter + 1;
                  
                  pggState <= m1p2;
   
               when m1p2 =>
               
                  pggR     <= pggPixelData( 31 downto 27 ) & "000";
                  pggG     <= pggPixelData( 26 downto 21 ) & "00";                  
                  pggB     <= pggPixelData( 20 downto 16 ) & "000";

                        
                  pggState <= m1p3;

               when m1p3 =>
               
                  pggPixelData <= gfxBufRamDOut;
               
                  if pgFetchEnable = '1' then

                        pggState <= m1p0;

                    else

                        pggState <= m1post0;

                    end if;
                    
                    
               when m1post0 =>

--                RiscV
                  pggR     <= pggPixelData( 15 downto 11 ) & "000";
                  pggG     <= pggPixelData( 10 downto 5  ) & "00";                  
                  pggB     <= pggPixelData( 4  downto 0  ) & "000";

                  pggState <= m1post1;
                  
               when m1post1 =>
               
                  pggState <= m1post2;
                  
               when m1post2 =>

--                RiscV
                  pggR     <= pggPixelData( 31 downto 27 ) & "000";
                  pggG     <= pggPixelData( 26 downto 21 ) & "00";                  
                  pggB     <= pggPixelData( 20 downto 16 ) & "000";


                  pggState <= m1post3;
                  
               when m1post3 =>

                  pggState <= m1hblank;
               
               when m1hblank =>
               
                  --inc line counter
                  pggLineCounter <= pggLineCounter + 1;
               
                  pggR <= ( others => '0' );
                  pggG <= ( others => '0' );
                  pggB <= ( others => '0' );
                  
                  pggState <= m1pre0;

               
               ----------------------------------------------
               --mode 2: 640x480x16
               
               --wait for fetch enable
               --7 prefetch states to match 8 clock cycles between fetch enable and display enable
               when m2pre0 =>
               
                  pggR <= ( others => '0' );
                  pggG <= ( others => '0' );
                  pggB <= ( others => '0' );

                  
                  --pass dma request for first displayed line
                  if pgPreFetchLine = '1' then
                  
                     --fill lower line
                     
                     pggDMARequest  <= "01";
                     
                  else
                  
                     pggDMARequest  <= "00";
                  
                  end if;

                  --reset line buf address counter
                  pggGfxBufAddressCounter <= ( others => '0' );
                  
               
                  if pgFetchEnable = '1' then
                    
                        --pre fetch first data
                        pggState <= m2pre1;

                 end if;

                 --switch mode if necesary
                  if pgVideoMode = "00" then
                  
                     pggState <= m1pre0;
                     
                  end if;
               
               when m2pre1 =>

                  gfxBufRamRdA            <= pggGfxBufAddressCounter;
                  pggGfxBufAddressCounter <= pggGfxBufAddressCounter + 1;
                  
                  pggState <= m2pre2;
               
               when m2pre2 =>
                  
                  --dma requests
                  
                  --display lower buffer half, fill upper
                     
                  pggDMARequest  <= "10";
                                       
                  pggState <= m2pre3;
                  
               when m2pre3 =>
               
                  pggPixelData            <= gfxBufRamDOut;
                  
                  gfxBufRamRdA            <= pggGfxBufAddressCounter;

                  pggState <= m2pre4;
                  
               when m2pre4 =>
               
                  --clear dma request
                  pggDMARequest  <= ( others => '0' );
               
                  pggState <= m2pre5;
               
               when m2pre5 =>
               
                  pggState <= m2pre6;
                  
               when m2pre6 =>
               
               
                  pggState <= m2p0;
                  
               when m2p0 =>
               
--                RISCV
                  pggR     <= pggPixelData( 15 downto 11 ) & "000";
                  pggG     <= pggPixelData( 10 downto 5  ) & "00";                  
                  pggB     <= pggPixelData( 4  downto 0  ) & "000";
            
--                MC68K
--                pggR     <= pggPixelData( 31 downto 27 ) & "000";
--                pggG     <= pggPixelData( 26 downto 21 ) & "00";                  
--                pggB     <= pggPixelData( 20 downto 16 ) & "000";
               
                  
                  
                  --display higher buffer half, fill lower
                  --middle acreen is 48 + 640 / 2 = 368 - 1 px
                  --adjust this when video timings changed 
                  if pgXCount( 11 downto 1 ) = "00010110111" then

                     --fetch lowe buffer part
                     pggDMARequest           <= "01";

                     --switch data fetch address to higher buffer part
                     pggGfxBufAddressCounter <= "100000001";
                     gfxBufRamRdA            <= "100000000";
                     
                  else
                  
                     gfxBufRamRdA            <= pggGfxBufAddressCounter;
                     pggGfxBufAddressCounter <= pggGfxBufAddressCounter + 1;

                     pggDMARequest  <= "00";
                  
                  end if;
                  
                  pggState <= m2p1;

               when m2p1 =>
               
                  pggR     <= pggPixelData( 31 downto 27 ) & "000";
                  pggG     <= pggPixelData( 26 downto 21 ) & "00";                  
                  pggB     <= pggPixelData( 20 downto 16 ) & "000";

                  pggPixelData <= gfxBufRamDOut;
                  
                  if pgDeX = '1' then

                        pggState <= m2p0;

                  else

                        pggState <= m2hblank;

                  end if;
                    
                    
               
               when m2hblank =>
               
               
                  pggR <= ( others => '0' );
                  pggG <= ( others => '0' );
                  pggB <= ( others => '0' );
                  
                  pggState <= m2pre0;
               
               
               
               when others =>
               
                  pggState <= m1pre0;
            
            end case;
         
         end if;
         
      end if;
   
   end process;
   



end behavior;
