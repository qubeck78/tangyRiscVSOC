library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera_mf;
use altera_mf.altera_mf_components.all;


entity blitter is

generic(
	inst3DAcceleration:		boolean := true
);

port(

	--cpu interface

	reset:				in  	std_logic;
	clock:				in  	std_logic;
	a:						in 	std_logic_vector( 15 downto 0 );
	din:					in 	std_logic_vector( 31 downto 0 );
	dout:					out	std_logic_vector( 31 downto 0 );
	
	ce:					in		std_logic;
	wr:					in		std_logic;
	dataMask:			in		std_logic_vector( 3 downto 0 );
	
	ready:				out	std_logic;
	
	--dma interface
	
	dmaDin:				in		std_logic_vector( 31 downto 0 );
	dmaDout:				out	std_logic_vector( 31 downto 0 );
	
	dmaA:					out	std_logic_vector( 21 downto 0 );
	dmaRWn:				out	std_logic;
	dmaRequest:			out	std_logic;
	dmaTransferSize:	out 	std_logic;
	dmaTransferMask:	out	std_logic_vector( 1 downto 0 );
	dmaReady:			in		std_logic

);

end blitter;

architecture behavior of blitter is

--components

--gouraud edge computation component
component gouraudEdge is
port(
	--reset
	 reset:                          in  std_logic;
    clock:                          in  std_logic;
	
	 e1_x:									in std_logic_vector( 15 downto 0 );
	 e1_y:									in std_logic_vector( 15 downto 0 );
	 
	 e2_x:									in std_logic_vector( 15 downto 0 );
	 e2_y:									in std_logic_vector( 15 downto 0 );

	 p_x:										in std_logic_vector( 15 downto 0 );
	 p_y:										in std_logic_vector( 15 downto 0 );

	 
	 edge:									out std_logic_vector( 31 downto 0 )
);
end component;


--gouraud weight computation component
component gouraudWeight is
port(
	--reset
	 reset:                          in  std_logic;
    clock:                          in  std_logic;
	 
	 edge:									in std_logic_vector( 31 downto 0 );
	 area:									in std_logic_vector( 31 downto 0 );
	 
	 weight:									out std_logic_vector( 31 downto 0 )

);
end component;


--gouraud iterator computation component
component gouraudIterator is
port(
	--reset
	 reset:                          in  std_logic;
    clock:                          in  std_logic;
	 	 
	 weightCB:								in  std_logic_vector( 15 downto 0 );
	 weightAC:								in  std_logic_vector( 15 downto 0 );
	 weightBA:								in  std_logic_vector( 15 downto 0 );

	 valA:									in  std_logic_vector( 7 downto 0 );
	 valB:									in  std_logic_vector( 7 downto 0 );
	 valC:									in  std_logic_vector( 7 downto 0 );

	 valOut:									out std_logic_vector( 7 downto 0 )
);
end component;

component gouraudIterator16 is
port(
	--reset
	 reset:                          in  std_logic;
    clock:                          in  std_logic;
	 	 
	 weightCB:								in  std_logic_vector( 15 downto 0 );
	 weightAC:								in  std_logic_vector( 15 downto 0 );
	 weightBA:								in  std_logic_vector( 15 downto 0 );

	 valA:									in  std_logic_vector( 15 downto 0 );
	 valB:									in  std_logic_vector( 15 downto 0 );
	 valC:									in  std_logic_vector( 15 downto 0 );

	 valOut:									out std_logic_vector( 15 downto 0 )
);
end component;

component textureShader is
port(
	--reset
	 reset:                          in  std_logic;
    clock:                          in  std_logic;
	 	 
	 colorIn:								in  std_logic_vector( 15 downto 0 );
	 lightIn:								in  std_logic_vector( 4 downto 0 );
	 colorOut:								out std_logic_vector( 15 downto 0 )
);
end component;


-- pixel alpha channel calculator

component pixelAlpha is
port(
	--reset
	 reset:                          in  std_logic;
    clock:                          in  std_logic;
	 	 
	 colorInA:								in  std_logic_vector( 15 downto 0 );
	 colorInB:								in  std_logic_vector( 15 downto 0 );
	 alpha:									in  std_logic_vector( 4 downto 0 );
	 colorOut:								out std_logic_vector( 15 downto 0 )
);
end component;

--signals

--registers 

type bltRegState_T is ( rsWaitForRegAccess, rsWaitForBusCycleEnd );

signal	state:					bltRegState_T;
signal	bltRegistersClock:	std_logic;


--gouraud edge computation components signals
signal c0Clock:	std_logic;

signal c0CX:		std_logic_vector( 15 downto 0 );
signal c0CY:		std_logic_vector( 15 downto 0 );
signal c0CZ:		std_logic_vector( 15 downto 0 );

signal c0BX:		std_logic_vector( 15 downto 0 );
signal c0BY:		std_logic_vector( 15 downto 0 );
signal c0BZ:		std_logic_vector( 15 downto 0 );
	 
signal c0AX:		std_logic_vector( 15 downto 0 );
signal c0AY:		std_logic_vector( 15 downto 0 );
signal c0AZ:		std_logic_vector( 15 downto 0 );

signal c0Px:		std_logic_vector( 15 downto 0 );
signal c0PxReg:		std_logic_vector( 15 downto 0 );
signal c0Py:		std_logic_vector( 15 downto 0 );
signal c0PyReg:		std_logic_vector( 15 downto 0 );

signal c0EdgeEBA:	std_logic_vector( 31 downto 0 );
signal c0EdgeECB:	std_logic_vector( 31 downto 0 );
signal c0EdgeEAC:	std_logic_vector( 31 downto 0 );

signal c0Area:		std_logic_vector( 31 downto 0 );

signal c0wba:		std_logic_vector( 31 downto 0 );
signal c0wcb:		std_logic_vector( 31 downto 0 );
signal c0wac:		std_logic_vector( 31 downto 0 );

signal c0it0A:		std_logic_vector( 7 downto 0 );
signal c0it0B:		std_logic_vector( 7 downto 0 );
signal c0it0C:		std_logic_vector( 7 downto 0 );
signal c0it0Out:	std_logic_vector( 7 downto 0 );

signal c0it1A:		std_logic_vector( 7 downto 0 );
signal c0it1B:		std_logic_vector( 7 downto 0 );
signal c0it1C:		std_logic_vector( 7 downto 0 );
signal c0it1Out:	std_logic_vector( 7 downto 0 );

signal c0it2A:		std_logic_vector( 7 downto 0 );
signal c0it2B:		std_logic_vector( 7 downto 0 );
signal c0it2C:		std_logic_vector( 7 downto 0 );
signal c0it2Out:	std_logic_vector( 7 downto 0 );

signal c0itZout:	std_logic_vector( 15 downto 0 );
signal c0itZoutLatched:	std_logic_vector( 15 downto 0 );

--blitter signals
signal bltClock:					std_logic;

signal bltReady:					std_logic;
signal bltRun:						std_logic;

signal bltConfig0Reg:			std_logic_vector( 31 downto 0 );

signal bltValueReg:				std_logic_vector( 31 downto 0 );

signal bltSrcAddressReg:		std_logic_vector( 21 downto 0 );
signal bltSrcAddress:			std_logic_vector( 21 downto 0 );
signal bltSrcAddress2:			std_logic_vector( 21 downto 0 );

signal bltSrcModuloReg:			std_logic_vector( 15 downto 0 );
signal bltSrcModulo2:			std_logic_vector( 15 downto 0 );

signal bltDestAddressReg:		std_logic_vector( 21 downto 0 );
signal bltDestAddress:			std_logic_vector( 21 downto 0 );

signal bltDestModuloReg:		std_logic_vector( 15 downto 0 );

signal bltTransferWidthReg:	std_logic_vector( 15 downto 0 );
signal bltTransferHeightReg:	std_logic_vector( 8 downto 0 );

signal bltAccumulator:			std_logic_vector( 31 downto 0 );
signal bltTransferCounterX:	std_logic_vector( 15 downto 0);
signal bltTransferCounterY:	std_logic_vector( 8 downto 0);

--bounding box calc
type bboxState_t is ( bbstReady, bbst1, bbst2, bbst3, bbst4, bbst5 );
signal bboxState:					bboxState_t;

signal axUs:	std_logic_vector( 15 downto 0 );
signal ayUs:	std_logic_vector( 15 downto 0 );

signal bxUs:	std_logic_vector( 15 downto 0 );
signal byUs:	std_logic_vector( 15 downto 0 );

signal cxUs:	std_logic_vector( 15 downto 0 );
signal cyUs:	std_logic_vector( 15 downto 0 );

--trigger bounding box calculation ( by writting bltConfig0 reg )

signal bboxRunCalc:				std_logic;

signal bltGouraudXminReg:		std_logic_vector( 15 downto 0 );
signal bltGouraudYminReg:		std_logic_vector( 15 downto 0 );
signal bltGouraudXmaxReg:		std_logic_vector( 15 downto 0 );
signal bltGouraudYmaxReg:		std_logic_vector( 15 downto 0 );

signal bltGouraudZBufferAddressReg:		std_logic_vector( 21 downto 0 );
signal bltGouraudZBufferAddress:			std_logic_vector( 21 downto 0 );

signal bltAlphaReg:				std_logic_vector( 15 downto 0 );


signal bltYOffset:				std_logic_vector( 31 downto 0 );

signal bltInsideTriangleFlag:	std_logic;

signal bltScalerDeltaXReg:			std_logic_vector( 31 downto 0 );
signal bltScalerDeltaYReg:			std_logic_vector( 31 downto 0 );
signal bltScalerSourceWidthReg:	std_logic_vector( 15 downto 0 );
signal bltScalerSourceHeightReg:	std_logic_vector( 9 downto 0 );

signal bltScalerSourceCX:			std_logic_vector( 31 downto 0 );
signal bltScalerSourceCY:			std_logic_vector( 31 downto 0 );
signal bltScalerLineAddress:		std_logic_vector( 21 downto 0 );


type bltState_t is ( bltStIdle, bltStWriteSignleVal0,  bltStWriteSignleVal1, bltStWriteSignleVal2, bltStWriteSignleVal3,
							bltStCopy0, bltStCopy1, bltStCopy2, bltStCopy3, bltStCopy4, bltStCopy5, bltStCopy6,
							bltStGouraud0, bltStGouraud1, bltStGouraud2, bltStGouraud3, bltStGouraud4, bltStGouraud5, bltStGouraud6, bltStGouraud7,
							bltStGouraud8, bltStGouraud9, bltStGouraud10, bltStGouraud11, bltStGouraud12,
							bltStScaleCopy0, bltStScaleCopy1, bltStScaleCopy2, bltStScaleCopy3, bltStScaleCopy4, bltStScaleCopy5,
							bltStSubWrite0, bltStSubWrite1, bltStSubWrite2, bltStSubWrite3,
							bltStSubRead0, bltStSubRead1, bltStSubRead2, bltStSubRead3,
							bltStSubRead2_0,
							
							bltStSubWriteWithZBuf0, bltStSubWriteWithZBuf1, bltStSubWriteWithZBuf2, bltStSubWriteWithZBuf3, bltStSubWriteWithZBuf4
							
						 );

signal bltState:				bltState_t;
signal bltReturnState:		bltState_t;


--texture shader signals
signal txtShaderClock:		std_logic;
signal txtShaderColorIn:	std_logic_vector( 15 downto 0 );
signal txtShaderLightIn:	std_logic_vector( 4 downto 0 );
signal txtShaderColorOut:	std_logic_vector( 15 downto 0 );
	 
	 
--pixel alpha signals
signal pixAlphaClock:		std_logic;
signal pixAlphaColorInA:	std_logic_vector( 15 downto 0 );
signal pixAlphaColorInB:	std_logic_vector( 15 downto 0 );
signal pixAlphaAlpha:		std_logic_vector( 4 downto 0 );
signal pixAlphaColorOut:	std_logic_vector( 15 downto 0 );

begin

--clock distribution

--blitter clock
	bltClock				<= clock;

--blitter registers clock
	bltRegistersClock	<= clock;
	
--gouraud computation component clock
	c0Clock				<= clock;

--texture shader clock
	txtShaderClock		<= clock;

-- pixel alpha channel calculator clock
	pixAlphaClock		<= clock;

	
blitterRegisters: process( all )
	begin

		if rising_edge( bltRegistersClock ) then
		
			if reset = '1' then
			
				ready	<= '0';	
				state	<= rsWaitForRegAccess;
				
				--set registers to default values

				--gouraud edge components 
				c0CX							<= ( others => '0' );
				c0CY							<= ( others => '0' );
				c0CZ							<= ( others => '0' );
			
				c0BX							<= ( others => '0' );
				c0BY							<= ( others => '0' );
				c0BZ							<= ( others => '0' );
			
				c0AX							<= ( others => '0' );
				c0AY							<= ( others => '0' );
				c0AZ							<= ( others => '0' );
			
				c0PxReg						<= ( others => '0' );
				c0PyReg						<= ( others => '0' );

				--c0Area						<= x"00000001";
			
				c0it0A						<= ( others => '0' );
				c0it0B						<= ( others => '0' );
				c0it0C						<= ( others => '0' );
			
				c0it1A						<= ( others => '0' );
				c0it1B						<= ( others => '0' );
				c0it1C						<= ( others => '0' );

				c0it2A						<= ( others => '0' );
				c0it2B						<= ( others => '0' );
				c0it2C						<= ( others => '0' );

				bltConfig0Reg				<= ( others => '0' );
				bltValueReg					<= ( others => '1' );
				bltSrcAddressReg			<= ( others => '0' );
				bltSrcModuloReg			<= ( others => '0' );
				bltDestAddressReg			<= ( others => '0' );
				bltDestModuloReg			<= ( others => '0' );
				bltTransferWidthReg		<= ( others => '0' );
				bltTransferHeightReg		<= ( others => '0' );
			
			
				bltAlphaReg					<= x"00"&"00011111";

				bltScalerDeltaXReg		<= ( others => '0' );
				bltScalerDeltaYReg		<= ( others => '0' );
				bltScalerSourceWidthReg	<= ( others => '0' );
				bltScalerSourceHeightReg<= ( others => '0' );
				
				
				--reset triggers
				bltRun							<= '0';
				bboxRunCalc						<= '0';

			else

				--reset triggers
				bltRun							<= '0';
				bboxRunCalc						<= '0';
			
				case state is
		
					when rsWaitForRegAccess =>
				
						if ce = '1' then
						
							--cpu wants to access registers
						
							ready <= '0';
							
							case a is
							
								---w 0x0000 - c0AX							
								when x"0000" =>
										
									if wr = '1' then
				
										c0AX	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';
									
								---w 0x0004 - c0AY
								when x"0001" =>
																					
									if wr = '1' then
				
										c0AY	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';

								---w 0x0008 - c0BX
								when x"0002" =>
																					
									if wr = '1' then
				
										c0BX	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';

								---w 0x000c - c0BY
								when x"0003" =>
																					
									if wr = '1' then
				
										c0BY	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';

									
								---w 0x0010 - c0CX
								when x"0004" =>
																					
									if wr = '1' then
				
										c0CX	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';

								---w 0x0014 - c0CY
								when x"0005" =>
																					
									if wr = '1' then
				
										c0CY	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';
																	
								--rw 0x0018 - c0px
								when x"0006" =>
														
									dout	<= x"0000" & c0PxReg;
									
									if wr = '1' then
				
										c0PxReg	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';
									
								--rw 0x001c - c0py
								when x"0007" =>
														
									dout	<= x"0000" & c0PyReg;
									
									if wr = '1' then
				
										c0PyReg	<= din( 15 downto 0 );
									
									end if;

									ready	<= '1';
									
								--r- 0x0020 - c0EdgeEBA
								when x"0008" =>
														
									dout	<= c0EdgeEBA;

									ready	<= '1';

								--r- 0x0024 - c0EdgeECB
								when x"0009" =>
														
									dout	<= c0EdgeECB;

									ready	<= '1';
									
								--r- 0x0028 - c0EdgeEAC
								when x"000a" =>
														
									dout	<= c0EdgeEAC;

									ready	<= '1';

								--r- 0x002c - c0PInside
								when x"000b" =>
									
									if c0EdgeEBA( 31 ) = '0' and c0EdgeECB( 31 ) = '0' and c0edgeEAC( 31 ) = '0' then
								
										dout	<= x"00010001";	

									else

										dout	<= ( others => '0' );	
										
									end if;
								
									ready	<= '1';

								--r- 0x0030 - c0Area
								when x"000c" =>
														
									dout	<= c0Area;

									ready	<= '1';
	
								--r- 0x0034 - c0wba
								when x"000d" =>
														
									dout	<= c0wba;

									ready	<= '1';
	
								--r- 0x0038 - c0wcb
								when x"000e" =>
														
									dout	<= c0wcb;

									ready	<= '1';
	
								--r- 0x003c - c0wac
								when x"000f" =>
														
									dout	<= c0wac;

									ready	<= '1';
									
								--rw 0x0040 - c0it0A
								when x"0010" =>
														
									dout	<= x"000000" & c0it0A;
					
									if wr = '1' then
									
										c0it0A	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';
									
								--rw 0x0044 - c0it0B
								when x"0011" =>
														
									dout	<= x"000000" & c0it0B;
					
									if wr = '1' then
									
										c0it0B	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';
									
								--rw 0x0048 - c0it0C
								when x"0012" =>
														
									dout	<= x"000000" & c0it0C;
					
									if wr = '1' then
									
										c0it0C	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';

								--rw 0x004c - c0It0Out
								when x"0013" =>
														
									dout	<= x"000000" & c0It0Out;
														
									ready	<= '1';
	
								--rw 0x0050 - c0it1A
								when x"0014" =>
														
									dout	<= x"000000" & c0it1A;
					
									if wr = '1' then
									
										c0it1A	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';
	
								--rw 0x0054 - c0it1B
								when x"0015" =>
														
									dout	<= x"000000" & c0it1B;
					
									if wr = '1' then
									
										c0it1B	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';

								--rw 0x0058 - c0it1C
								when x"0016" =>
														
									dout	<= x"000000" & c0it1C;
					
									if wr = '1' then
									
										c0it1C	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';
	
								--rw 0x005c - c0It1Out
								when x"0017" =>
														
									dout	<= x"000000" & c0It1Out;
														
									ready	<= '1';

								--rw 0x0060 - c0it2A
								when x"0018" =>
														
									dout	<= x"000000" & c0it2A;
					
									if wr = '1' then
									
										c0it2A	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';
									
								--rw 0x0064 - c0it2B
								when x"0019" =>
														
									dout	<= x"000000" & c0it2B;
					
									if wr = '1' then
									
										c0it2B	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';

								--rw 0x0068 - c0it2C
								when x"001a" =>
														
									dout	<= x"000000" & c0it2C;
					
									if wr = '1' then
									
										c0it2C	<= din( 7 downto 0 );
										
									end if;
									
									ready	<= '1';
								
								--rw 0x006c - c0It2Out
								when x"001b" =>
														
									dout	<= x"000000" & c0It2Out;
														
									ready	<= '1';

								--rw 0x0070 - bltStatus
								when x"001c" =>
														
									dout	<= x"0000000" & "000" & bltReady;
					
									if wr = '1' then
									
										bltRun <= '1';
										
									end if;
									
									ready	<= '1';
	
								--rw 0x0074 - bltConfig0
								when x"001d" =>
														
									dout	<= bltConfig0Reg;
					
									if wr = '1' then
									
										bltConfig0Reg <= din;
										
										--calc gouraud triangle bounding box
										bboxRunCalc	<= '1';
							
									end if;
									
									ready	<= '1';
									
								--rw 0x0078 - bltValue
								when x"001e" =>
														
									dout	<= bltValueReg;
					
									if wr = '1' then
									
										bltValueReg <= din;
																	
									end if;
									
									ready	<= '1';
									
								--rw 0x007c - bltSrcAddress
								when x"001f" =>
														
									dout	<= "0000000000" & bltSrcAddressReg;
					
									if wr = '1' then
									
										bltSrcAddressReg <= din( 21 downto 0 );
																	
									end if;
									
									ready	<= '1';									
							
								--rw 0x0080 - bltDestAddress
								when x"0020" =>
														
									dout	<= "0000000000" & bltDestAddressReg;
					
									if wr = '1' then
									
										bltDestAddressReg <= din( 21 downto 0 );
																	
									end if;
									
									ready	<= '1';									
							
								--rw 0x0084 - bltSrcModulo
								when x"0021" =>
														
									dout	<= x"0000" & bltSrcModuloReg;
					
									if wr = '1' then
									
										bltSrcModuloReg <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';									
							
								--rw 0x0088 - bltDestModulo
								when x"0022" =>
														
									dout	<= x"0000" & bltDestModuloReg;
					
									if wr = '1' then
									
										bltDestModuloReg <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';									
							
								--rw 0x008c - bltTransferWidth
								when x"0023" =>
														
									dout	<= x"0000" & bltTransferWidthReg;
					
									if wr = '1' then
									
										bltTransferWidthReg <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';	

								--rw 0x0090 - bltTransferHeight
								when x"0024" =>
														
									dout	<= x"0000" & x"0" & "000" & bltTransferHeightReg;
					
									if wr = '1' then
									
										bltTransferHeightReg <= din( 8 downto 0 );
																	
									end if;
									
									ready	<= '1';	
									
								--rw 0x0094 - bltAlpha
								when x"0025" =>
														
									dout	<= x"0000" & bltAlphaReg;
					
									if wr = '1' then
									
										bltAlphaReg <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';	

								--rw 0x0098 - c0AZ
								when x"0026" =>
														
									dout	<= x"0000" & c0AZ;
					
									if wr = '1' then
									
										c0AZ <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';	
									
								--rw 0x009c - c0BZ
								when x"0027" =>
														
									dout	<= x"0000" & c0BZ;
					
									if wr = '1' then
									
										c0BZ <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';	

								--rw 0x00a0 - c0CZ
								when x"0028" =>
														
									dout	<= x"0000" & c0CZ;
					
									if wr = '1' then
									
										c0CZ <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';	

								--rw 0x00a4 - bltGouraudZBufferAddressReg
								when x"0029" =>
														
									dout	<= "0000000000" & bltGouraudZBufferAddressReg;
					
									if wr = '1' then
									
										bltGouraudZBufferAddressReg <= din( 21 downto 0 );
																	
									end if;
									
									ready	<= '1';	

								--rw 0x00a8 - bltScalerDeltaX
								when x"002a" =>
														
									dout	<= bltScalerDeltaXReg;
					
									if wr = '1' then
									
										bltScalerDeltaXReg <= din;
																	
									end if;
									
									ready	<= '1';	

								--rw 0x00ac - bltScalerDeltaY
								when x"002b" =>
														
									dout	<= bltScalerDeltaYReg;
					
									if wr = '1' then
									
										bltScalerDeltaYReg <= din;
																	
									end if;
									
									ready	<= '1';	

								--rw 0x00b0 - bltScalerSourceWidth
								when x"002c" =>
														
									dout	<= x"0000" & bltScalerSourceWidthReg;
					
									if wr = '1' then
									
										bltScalerSourceWidthReg <= din( 15 downto 0 );
																	
									end if;
									
									ready	<= '1';	
	
								--rw 0x00b4 - bltScalerSourceHeight
								when x"002d" =>
														
									dout	<= x"0000" & "000000" & bltScalerSourceHeightReg;
					
									if wr = '1' then
									
										bltScalerSourceHeightReg <= din( 9 downto 0 );
																	
									end if;
									
									ready	<= '1';	

								when others =>
								
									dout	<= ( others =>'0' );
									ready	<= '1';
							
							end case; --a
						
							state <= rsWaitForBusCycleEnd;
						
						end if; --ce = '1'
									
					
					when rsWaitForBusCycleEnd =>
					
						--wait for bus cycle to end
						if ce = '0' then
						
							state <= rsWaitForRegAccess;
							ready	<= '0';
							
						end if;
						
					when others =>
					
						state <= rsWaitForRegAccess;
				
				end case; --state
		
			end if; --reset = '1'
		
		
		end if; --rising_edge( bltRegistersClock )
	
	end process;
	
	
--place pixel alpha
pixelAlphaInst:pixelAlpha
port map(
	 reset		=> reset,
    clock		=> pixAlphaClock,
	 	 
	 colorInA	=> pixAlphaColorInA,
	 colorInB	=> pixAlphaColorInB,
	 alpha		=> pixAlphaAlpha,
	 colorOut	=> pixAlphaColorOut
);


inst3DAccelerationGen: if ( inst3DAcceleration = true ) generate

--place gouraud edge computation components

gouraudEdgeInst1:	gouraudEdge
	port map(
		
		reset		=> reset,
		clock		=> c0Clock,
		
		e1_x		=> c0BX,
		e1_y		=> c0BY,
		
		e2_x		=> c0AX,
		e2_y		=> c0AY,
		
		p_x		=>	c0Px,
		p_y		=> c0Py,
		
		edge		=> c0EdgeEBA
		
	);
	
gouraudEdgeInst2:	gouraudEdge
	port map(
		
		reset		=> reset,
		clock		=> c0Clock,
		
		e1_x		=> c0CX,
		e1_y		=> c0CY,
		
		e2_x		=> c0BX,
		e2_y		=> c0BY,
		
		p_x		=>	c0Px,
		p_y		=> c0Py,
		
		edge		=> c0EdgeECB
		
	);

gouraudEdgeInst3:	gouraudEdge
	port map(
		
		reset		=> reset,
		clock		=> c0Clock,
		
		e1_x		=> c0AX,
		e1_y		=> c0AY,
		
		e2_x		=> c0CX,
		e2_y		=> c0CY,
		
		p_x		=>	c0Px,
		p_y		=> c0Py,
		
		edge		=> c0EdgeEAC
		
	);	

gouraudEdgeInst4:	gouraudEdge
	port map(
		
		reset		=> reset,
		clock		=> c0Clock,
		
		e1_x		=> c0CX,
		e1_y		=> c0CY,
		
		e2_x		=> c0BX,
		e2_y		=> c0BY,
		
		p_x		=>	c0AX,
		p_y		=> c0AY,
		
		edge		=> c0Area
		
	);	
	
-- place gouraud weight computation components
gouraudWeightInst1: gouraudWeight 
	port map(
	
	 reset	=> reset,
    clock	=> c0Clock,
	 
	 edge		=> c0edgeEBA,
	 area		=> c0area,
	 
	 weight	=> c0wba
);
	
gouraudWeightInst2: gouraudWeight 
	port map(
	
	 reset	=> reset,
    clock	=> c0Clock,
	 
	 edge		=> c0edgeECB,
	 area		=> c0area,
	 
	 weight	=> c0wcb
);
	
gouraudWeightInst3: gouraudWeight 
	port map(
	
	 reset	=> reset,
    clock	=> c0Clock,
	 
	 edge		=> c0edgeEAC,
	 area		=> c0area,
	 
	 weight	=> c0wac
);
	
	
--place gouraud iterator computation components
gouraudIteratorInst0: gouraudIterator
port map(
	 reset			=> reset,
    clock			=> c0Clock,
	 	 
	 weightCB		=> c0wcb( 15 downto 0 ),
	 weightAC		=> c0wac( 15 downto 0 ),
	 weightBA		=> c0wba( 15 downto 0 ),

	 valA				=> c0it0A,
	 valB				=> c0it0B,
	 valC				=> c0it0C,

	 valOut			=> c0it0Out
);

gouraudIteratorInst1: gouraudIterator
port map(
	 reset			=> reset,
    clock			=> c0Clock,
	 	 
	 weightCB		=> c0wcb( 15 downto 0 ),
	 weightAC		=> c0wac( 15 downto 0 ),
	 weightBA		=> c0wba( 15 downto 0 ),

	 valA				=> c0it1A,
	 valB				=> c0it1B,
	 valC				=> c0it1C,

	 valOut			=> c0it1Out
);

gouraudIteratorInst2: gouraudIterator
port map(
	 reset			=> reset,
    clock			=> c0Clock,
	 	 
	 weightCB		=> c0wcb( 15 downto 0 ),
	 weightAC		=> c0wac( 15 downto 0 ),
	 weightBA		=> c0wba( 15 downto 0 ),

	 valA				=> c0it2A,
	 valB				=> c0it2B,
	 valC				=> c0it2C,

	 valOut			=> c0it2Out
);

gouraudIteratorInstZ: gouraudIterator16
port map(
	 reset			=> reset,
    clock			=> c0Clock,
	 	 
	 weightCB		=> c0wcb( 15 downto 0 ),
	 weightAC		=> c0wac( 15 downto 0 ),
	 weightBA		=> c0wba( 15 downto 0 ),

	 valA				=> c0AZ,
	 valB				=> c0BZ,
	 valC				=> c0CZ,

	 valOut			=> c0ItZout
);


--place texture shader
textureShaderInst: textureShader
port map(
	 reset		=> reset,
    clock		=> txtShaderClock,
	 	 
	 colorIn		=> txtShaderColorIn,
	 lightIn		=> txtShaderLightIn,
	 colorOut	=> txtShaderColorOut
);

end generate;

--gouraud triangle bounding box calculation
gouraudBoundingBox: process( all )

begin

	if rising_edge( bltClock ) then
	
		if reset = '1' then

			bboxState			<= bbstReady;
			bltGouraudXminReg	<= ( others => '0' );
			bltGouraudYminReg	<= ( others => '0' );
			bltGouraudXmaxReg	<= ( others => '0' );
			bltGouraudYmaxReg	<= ( others => '0' );

		
		else
				
			case bboxState is
		
				when bbStReady =>
			
					if bboxRunCalc = '1' then
				
						bboxState	<= bbSt1;
					
					end if;
			
			
				when bbSt1 =>
			
					bltGouraudXminReg	<= bltTransferWidthReg;		--x"0140";	--320
					bltGouraudXmaxReg	<= x"0000";
					bltGouraudYminReg	<= "0000000" & bltTransferHeightReg;	--x"00f0";	--240
					bltGouraudYmaxReg	<= x"0000";

					if c0AX( 15 ) = '0' then
						axUs <= c0AX;
					else
						axUs <= ( others => '0' );
					end if;
			
			
					if c0AY( 15 ) = '0' then
						ayUs <= c0AY;
					else
						ayUs <= ( others => '0' );
					end if;

					if c0BX( 15 ) = '0' then			
						bxUs <= c0BX;
					else
						bxUs <= ( others => '0' );
					end if;
			
					if c0BY( 15 ) = '0' then
						byUs <= c0BY;
					else
						byUs <= ( others => '0' );
					end if;
			
					if c0CX( 15 ) = '0' then
						cxUs <= c0CX;
					else
						cxUs <= ( others => '0' );
					end if;
			
					if c0CY( 15 ) = '0' then
						cyUs <= c0CY;
					else
						cyUs <= ( others => '0' );
					end if;

				
					if bboxRunCalc = '0' then
				
						bboxState	<= bbSt2;
				
					end if;
				
				when bbSt2 =>
			
					if axUs < bltGouraudXminReg then
						bltGouraudXminReg	<= axUs;
					end if;
				
					if ayUs < bltGouraudYminReg then
						bltGouraudYminReg	<= ayUs;
					end if;
				
					if axUs > bltGouraudXmaxReg then
						bltGouraudXmaxReg	<= axUs;
					end if;
				
					if ayUs > bltGouraudYmaxReg then
						bltGouraudYmaxReg	<= ayUs;
					end if;
				
					bboxState	<= bbSt3;
		
				when bbSt3 =>
			
					if bxUs < bltGouraudXminReg then
						bltGouraudXminReg	<= bxUs;
					end if;
				
					if byUs < bltGouraudYminReg then
						bltGouraudYminReg	<= byUs;
					end if;
				
					if bxUs > bltGouraudXmaxReg then
						bltGouraudXmaxReg	<= bxUs;
					end if;
				
					if byUs > bltGouraudYmaxReg then
						bltGouraudYmaxReg	<= byUs;
					end if;
				
					bboxState	<= bbSt4;
		
				when bbSt4 =>
			
					if cxUs < bltGouraudXminReg then
						bltGouraudXminReg	<= cxUs;
					end if;
				
					if cyUs < bltGouraudYminReg then
						bltGouraudYminReg	<= cyUs;
					end if;
				
					if cxUs > bltGouraudXmaxReg then
						bltGouraudXmaxReg	<= cxUs;
					end if;
				
					if cyUs > bltGouraudYmaxReg then
						bltGouraudYmaxReg	<= cyUs;
					end if;
				
					bboxState	<= bbSt5;

				when bbSt5 =>

					if bltGouraudXminReg >= bltTransferWidthReg then
						bltGouraudXminReg	<= bltTransferWidthReg - 1;
					end if;
				
					if bltGouraudXmaxReg > bltTransferWidthReg then
						bltGouraudXmaxReg	<= bltTransferWidthReg;
					end if;

					if bltGouraudYminReg >= bltTransferHeightReg then
						bltGouraudYminReg	<= "0000000" & bltTransferHeightReg - 1;
					end if;
			
					if bltGouraudYmaxReg > bltTransferHeightReg then
						bltGouraudYmaxReg	<= "0000000" & bltTransferHeightReg;
					end if;
				
					bboxState	<= bbStReady;

		end case;
		
		
		end if; --reset = '1'
	
	end if; --rising_edge( bltClock )


end process;


--blitter - raster operations coprocessor
blitterMain: process( all )
variable bltScalerLineAddressVar:	std_logic_vector( 31 downto 0 );

begin

	if rising_edge( bltClock ) then
	
		if reset = '1' then
			
			bltState					<= bltStIdle;
			bltReady					<= '1';
			dmaRequest				<= '0';
			
			bltReturnState			<= bltStIdle;
			bltAccumulator			<= ( others => '0' );
			bltYOffset				<= ( others => '0' );
			
			dmaRWn					<= '1';
			dmaDout					<= ( others => '0' );
			dmaA						<= ( others => '0' );
			
			dmaTransferMask		<= "11"; --use both words for 32 bit transfer

			bltScalerSourceCX		<= ( others => '0' );
			bltScalerSourceCY		<= ( others => '0' );
			bltScalerLineAddress	<= ( others => '0' );
			
		else
	
	
			case bltState is
			
				when bltStIdle =>
			
					--pass c0pXReg to c0Px and c0PyReg to c0Py, in idle gouraud is controlled by cpu
					
					c0Px <= c0PxReg;
					c0Py <= c0PyReg;
			
					bltReady				<= '1';
					dmaRequest			<= '0';
					
					dmaTransferSize	<= bltConfig0Reg( 13 );
					
					if bltRun = '1' then
						
						bltInsideTriangleFlag	<= '0';	--clear inside triangle drawn flag
							
						case bltConfig0Reg( 3 downto 0 ) is
						
							--write value to dest addr
						

							when "0000" =>
								
								--fill dest with fixed value

								bltReady					<= '0';
							
								bltAccumulator			<= bltValueReg;
														
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
							
															
								bltState					<= bltStWriteSignleVal0;

							when "0001" =>
							
								--copy src to dest
								bltReady					<= '0';
								
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
								bltSrcAddress			<= bltSrcAddressReg;
								
								
								bltState					<= bltStCopy0;
								
							when "0010" =>
							
								--copt src to dest with mask value
								bltReady					<= '0';
								
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
								bltSrcAddress			<= bltSrcAddressReg;
								
								dmaTransferSize		<= '0';
								
								bltState					<= bltStCopy0;
								
							when "0011" =>
							
								--draw gouraud triangle :)
								bltReady					<= '0';
								
								c0Px						<= bltGouraudXminReg;
								c0Py						<= bltGouraudYminReg;
															
								bltState					<= bltStGouraud0;
								
							when "0100" =>
								
								--draw textured triangle :)
								bltReady					<= '0';
								
								c0Px						<= bltGouraudXminReg;
								c0Py						<= bltGouraudYminReg;
								

								bltState					<= bltStGouraud0;
								
							when "0101" =>
								
								--draw textured triangle with lighting :)
								bltReady					<= '0';
								
								c0Px						<= bltGouraudXminReg;
								c0Py						<= bltGouraudYminReg;
								

								bltState					<= bltStGouraud0;
						
							when "0110" =>
							
								--copt src to dest with alpha 
								bltReady					<= '0';
								
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
								bltSrcAddress			<= bltSrcAddressReg;
								bltSrcAddress2			<= bltDestAddressReg;
								bltSrcModulo2			<= bltDestModuloReg;
								
								pixAlphaAlpha			<= bltAlphaReg( 4 downto 0 );
								

								bltState					<= bltStCopy0;
							
							when "0111" =>
							
								--copy src to dest with alpha and mask
								bltReady					<= '0';
								
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
								bltSrcAddress			<= bltSrcAddressReg;
								bltSrcAddress2			<= bltDestAddressReg;
								bltSrcModulo2			<= bltDestModuloReg;
								
								pixAlphaAlpha			<= bltAlphaReg( 4 downto 0 );
								

								bltState					<= bltStCopy0;
								
								
							when "1000" =>
							
								--scale copy src to dest
								bltReady					<= '0';
								
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
								bltSrcAddress			<= bltSrcAddressReg;
								
								bltScalerSourceCX		<= ( others => '0' );
								bltScalerSourceCY		<= bltScalerDeltaYReg;	--first line calculated, add delta
								
								bltScalerLineAddress	<= bltSrcAddressReg;
								
								bltState					<= bltStScaleCopy0;
							
							when "1001" =>
							
								--scale copy src to dest with mask
								bltReady					<= '0';
								
								bltTransferCounterX	<= bltTransferWidthReg;
								bltTransferCounterY	<= bltTransferHeightReg;
								bltDestAddress			<= bltDestAddressReg;
								bltSrcAddress			<= bltSrcAddressReg;
								
								bltScalerSourceCX		<= ( others => '0' );
								bltScalerSourceCY		<= bltScalerDeltaYReg;	--first line calculated, add delta
								
								bltScalerLineAddress	<= bltSrcAddressReg;
								
								bltState					<= bltStScaleCopy0;
							
							when others =>
							
								bltReady		<= '1';
								
						end case;
						
					end if;
					
				--gouraud
				when bltStGouraud0 =>
				
					if c0Px < bltGouraudXmaxReg then
					
						--draw
						
						
						--calc y offset
						bltYOffset 					<= bltDestModuloReg * c0Py;
						
						bltState						<= bltStGouraud1;
					
					else
						
						bltInsideTriangleFlag	<= '0';	--new line, clear inside flag
						
						c0Px	<= bltGouraudXminReg;
						
						if c0Py < bltGouraudYmaxReg then
	
							c0Py <= c0Py + 1;
	
						else
	
							--finish drawing
							bltState <= bltStIdle;
							
						end if;
					
					end if;
					
				when bltStGouraud1 =>

					
					if bltConfig0Reg( 12 ) = '1' then
					
						--z buffer enabled
						if bltInsideTriangleFlag = '0' then
						
							bltTransferCounterX	<= x"0008";		--no memory write delay, add 8 wait cycles
					
						else

							bltTransferCounterX	<= x"0003";		--memory write causes additional delay, add 3 wait cycles
					
						end if;
					
					else
					
						--z buffer disabled
						if bltInsideTriangleFlag = '0' then
						
							bltTransferCounterX	<= x"0007";		--no memory write delay, add 7 wait cycles
					
						else

							bltTransferCounterX	<= x"0003";		--memory write causes additional delay, add 3 wait cycles
					
						end if;
					
					end if;
					
					bltState	<= bltStGouraud2;

				when bltStGouraud2 =>

					if bltTransferCounterX /= x"0000" then
					
						bltTransferCounterX <= bltTransferCounterX - 1;
					
					else

						bltState	<= bltStGouraud3;
					
					end if;
					

				when bltStGouraud3 =>
				
					bltDestAddress					<= bltDestAddressReg + c0Px + bltYOffset( 19 downto 0 );
					bltGouraudZBufferAddress	<= bltGouraudZBufferAddressReg + c0Px + bltYOffset( 19 downto 0 );
					
					
					c0Px				<= c0Px + 1;
									
					if c0EdgeEBA( 31 ) = '0' and c0EdgeECB( 31 ) = '0' and c0edgeEAC( 31 ) = '0' then
						
						--inside triangle
						
						bltInsideTriangleFlag	<= '1';
						
						--latch z iterator output
						c0itZoutLatched			<= c0itZout;
						

		
						
						
						if bltConfig0Reg( 3 downto 0 ) = "0011" then
						
							--gouraud triangle
							

							--point is inside triangle, draw it

							--take rgb value from gouraud iterators
							bltAccumulator( 15 downto 0 )	<= c0it0Out( 7 downto 3 ) & c0it1Out( 7 downto 2 ) & c0it2Out( 7 downto 3 );
								
							if bltConfig0Reg( 12 ) = '1' then
							
								--z buffer enabled
								
								--write data if closer to the camera than background pixel
								bltReturnState <= bltStGouraud0;
								bltState			<= bltStSubWriteWithZBuf0;
								
							else
							
								--z buffer disabled
															
								--write data
								bltReturnState <= bltStGouraud0;
								bltState			<= bltStSubWrite0;
							
							end if;
							
						elsif bltConfig0Reg( 3 downto 0 ) = "0100" or bltConfig0Reg( 3 downto 0 ) = "0101" then
						
							--textured triangle
							
							--get texture color

							case bltConfig0Reg( 11 downto 8 ) is
							
								when x"0" =>
									
									--texture 16x16
									bltSrcAddress	<= bltSrcAddressReg + ( c0it1Out( 7 downto 4 ) & c0it0Out( 3 downto 4 ) );
								
								when x"1" =>
									
									--texture 32x32
									bltSrcAddress	<= bltSrcAddressReg + ( c0it1Out( 7 downto 3 ) & c0it0Out( 7 downto 3 ) );
									
								when x"2" =>
									
									--texture 64x64
									bltSrcAddress	<= bltSrcAddressReg + ( c0it1Out( 7 downto 2 ) & c0it0Out( 7 downto 2 ) );
								
								when x"3" =>
									
									--texture 128x128
									bltSrcAddress	<= bltSrcAddressReg + ( c0it1Out( 7 downto 1 ) & c0it0Out( 7 downto 1 ) );
									
								when others =>
									
									--texture 256x256
									bltSrcAddress	<= bltSrcAddressReg + ( c0it1Out( 7 downto 0 ) & c0it0Out( 7 downto 0 ) );
								
							end case;
							
							--store iterator 2 as light
							txtShaderLightIn	<= c0it2Out( 7 downto 3);
							
							if bltConfig0Reg( 3 downto 0 ) = "0100" then
							
								bltReturnState	<= bltStGouraud4;	--no lighting
							
							else
								
								bltReturnState	<= bltStGouraud9;	--lighting
							
							end if;
							
							bltState			<= bltStSubRead0;					
							
						end if;	--bltConfig0Reg( 3 downto 0 ) = "0100" or bltConfig0Reg( 3 downto 0 ) = "0101"
						
					else
						
						if bltInsideTriangleFlag = '1' then
						
							bltInsideTriangleFlag <= '0';
							c0Px <= bltTransferWidthReg + x"0001";
						
						end if;
						
						
						
						--point is outside triangle, discard it
						bltState		<= bltStGouraud0;
					
					end if;
					
				--textured triangle, no light
				when bltStGouraud4 =>								
				
					--texture color in accumulator, light disabled
					--write data
	
					bltReturnState <= bltStGouraud0;
	
					if bltConfig0Reg( 12 ) = '1' then
							
						--z buffer enabled					
						--write data only when z is closer to the camera than background
						bltState			<= bltStSubWriteWithZBuf0;				

					else
						
						--z buffer disabled
						bltState			<= bltStSubWrite0;
				
					end if;
				
				-- textured triange, light
				when bltStGouraud9 =>
				
					--lighting based on c0it2Out
					
					txtShaderColorIn 	<= bltAccumulator( 15 downto 0 );
					
						
					bltState <= bltStGouraud10;
					
					
				when bltStGouraud10 =>
				
					txtShaderColorIn 	<= bltAccumulator( 15 downto 0 );
				
					bltState <= bltStGouraud11;
					

				when bltStGouraud11 =>
				
					bltAccumulator( 15 downto 0 )	<= txtShaderColorOut;
				
					--texture color in accumulator

					bltReturnState <= bltStGouraud0;
					
					if bltConfig0Reg( 12 ) = '1' then
							
						--z buffer enabled					
						--write data only when z is closer to the camera than background
						bltState			<= bltStSubWriteWithZBuf0;

					else
						--z buffer disables
						--write data
						bltState			<= bltStSubWrite0;
					
					end if;
				
				--fill with single value
				when bltStWriteSignleVal0 =>
				
				
					if bltTransferCounterX /= x"0000" then
					
						bltReturnState	<= bltStWriteSignleVal1;
						bltState			<= bltStSubWrite0;
					
					else
					
						if bltTransferCounterY /= x"00" then
							
							bltTransferCounterY	<= bltTransferCounterY - 1;

							bltDestAddress 		<= bltDestAddress + bltDestModuloReg;
							blttransferCounterX	<= bltTransferWidthReg;
							
						else
						
							bltState			<= bltStIdle;

						end if; --bltTransferCounterY /= x"00"
						
					end if; --bltTransferCounterX /= x"0000"
					
				when bltStWriteSignleVal1 =>
				
					bltDestAddress			<= bltDestAddress + 1;
					bltTransferCounterX 	<= bltTransferCounterX - 1;
					
					bltState					<= bltStWriteSignleVal0;
				
				
				--copy from srcaddress to destaddress
				
				when bltStCopy0 =>
					
					if bltTransferCounterX /= x"0000" then
					
						--read value
						bltReturnState	<= bltStCopy1;
						bltState			<= bltStSubRead0;
					
					else
					
						if bltTransferCounterY /= x"00" then
							
							bltTransferCounterY	<= bltTransferCounterY - 1;

							bltSrcAddress			<= bltSrcAddress  + bltSrcModuloReg;
							bltSrcAddress2			<= bltSrcAddress2 + bltSrcModulo2;
							
							bltDestAddress 		<= bltDestAddress + bltDestModuloReg;
							blttransferCounterX	<= bltTransferWidthReg;
							
						else
						
							bltState			<= bltStIdle;

						end if; --bltTransferCounterY /= x"00"
						
					end if; --bltTransferCounterX /= x"0000"
				
				when bltStCopy1 => 
				
					--check blitter mode
					if bltConfig0Reg( 3 downto 0 ) = "0010" then
						
						--masked copy
						
						--check value
						if bltAccumulator( 15 downto 0 ) = bltValueReg( 15 downto 0 ) then
							
							--read value equals mask, do not store
							bltState	<= bltStCopy2;
						
						else

							--read value is different from mask, store it							
							bltReturnState	<= bltStCopy2;
							bltState 		<= bltStSubWrite0;
							
						end if;
					
					elsif bltConfig0Reg( 3 downto 0 ) = "0110" then
						
						--copy with alpha
					
						--write source1 to alpha reg
						pixAlphaColorInA	<= bltAccumulator( 15 downto 0 );
						
						--read source2 (background )
						
						bltReturnState	<= bltStCopy3;
						bltState 		<= bltStSubRead2_0;
						
					elsif bltConfig0Reg( 3 downto 0 ) = "0111" then
					
						--copy with alpha and mask
						--check value
						if bltAccumulator( 15 downto 0 ) = bltValueReg( 15 downto 0 ) then
							
							--read value equals mask, do not store
							bltState	<= bltStCopy2;
						
						else
							
							--write source1 to alpha reg
							pixAlphaColorInA	<= bltAccumulator( 15 downto 0 );
						
							--read source2 (background )
						
							bltReturnState	<= bltStCopy3;
							bltState 		<= bltStSubRead2_0;
						end if;
						
					else
						--normal copy
						--store value
						
						bltReturnState	<= bltStCopy2;
						bltState 		<= bltStSubWrite0;
					
					end if; --bltConfig0Reg( 3 downto 0 ) = "0010"
					
				when bltStCopy2 =>
				
					bltSrcAddress			<= bltSrcAddress  + 1;
					bltSrcAddress2			<= bltSrcAddress2 + 1;
					
					bltDestAddress			<= bltDestAddress + 1;
					bltTransferCounterX 	<= bltTransferCounterX - 1;
					
					bltState					<= bltStCopy0;
					
				when bltStCopy3 =>
				
				
					--write source2 to alpha reg
					pixAlphaColorInB	<= bltAccumulator( 15 downto 0 );
					
					bltState				<= bltStCopy4;
					
				when bltStCopy4 =>
					
					--waitstate
					
					bltState				<= bltStCopy5;
				
				when bltStCopy5 =>

					--get alpha pixel
					bltAccumulator( 15 downto 0 )	<= pixAlphaColorOut; 

					--write pixel
					bltReturnState	<= bltStCopy2;
					bltState 		<= bltStSubWrite0;
					
					
				when bltStScaleCopy0 =>
				
					if bltTransferCounterX /= x"0000" then
					
						bltScalerSourceCX		<= bltScalerSourceCX + bltScalerDeltaXReg;

						--read value
						bltReturnState	<= bltStScaleCopy4;
						bltState			<= bltStSubRead0;
					
					else
					
						if bltTransferCounterY /= x"00" then
							
							bltTransferCounterY	<= bltTransferCounterY - 1;

							bltScalerLineAddressVar := bltSrcAddressReg + ( bltScalerSourceWidthReg * bltScalerSourceCY( 31 downto 16 ) );
							bltScalerLineAddress		<= bltScalerLineAddressVar( 21 downto 0 );
							
							bltScalerSourceCX		<= ( others => '0' );
							
							bltDestAddress 		<= bltDestAddress + bltDestModuloReg;
							blttransferCounterX	<= bltTransferWidthReg;
							
							bltState			<= bltStScaleCopy1;	--go to wait states, set source address for new line

						else
						
							bltState			<= bltStIdle;

						end if; --bltTransferCounterY /= x"00"
						
					end if; --bltTransferCounterX /= x"0000"					
					
					
				when bltStScaleCopy1 =>

					--waitstate, executed only after change to the next line
					bltState <= bltStScaleCopy2;

				when bltStScaleCopy2 =>

					--waitstate, executed only after change to the next line
					bltState <= bltStScaleCopy3;

				when bltStScaleCopy3 =>

				
					bltScalerSourceCY		<= bltScalerSourceCY + bltScalerDeltaYReg;

					--source address - line beginning
					bltSrcAddress			<= bltScalerLineAddress;
					--read data
					bltState					<= bltStScaleCopy0;
					
					
				when bltStScaleCopy4 =>
				
					if bltConfig0Reg( 3 downto 0 ) = "1001" then
						
						--masked copy
						
						if bltAccumulator( 15 downto 0 ) = bltValueReg( 15 downto 0 ) then
							
							--value equasl mask, do not write
							bltState 	<= bltStScaleCopy5;
						
						else
							--store value
						
							bltReturnState	<= bltStScaleCopy5;
							bltState 		<= bltStSubWrite0;
						
						end if;
					
					else
						
						--normal copy
						--store value
						
						bltReturnState	<= bltStScaleCopy5;
						bltState 		<= bltStSubWrite0;
					
					end if;
					
						
				when bltStScaleCopy5 =>
						
					bltSrcAddress			<= bltScalerLineAddress  + bltScalerSourceCX( 31 downto 16 );
					
					
					bltDestAddress			<= bltDestAddress + 1;
					bltTransferCounterX 	<= bltTransferCounterX - 1;
					
					bltState					<= bltStScaleCopy0;
		
				--read source address and store in accumulator
				--return to state in bltReturnState
				when bltStSubRead0 =>
						
						dmaA				<= bltSrcAddress;
						dmaRWn			<= '1';
						
						dmaRequest		<= '1';
					
						bltState			<= bltStSubRead1;
				
				when bltStSubRead1 =>
				
					if dmaReady = '0' then
					
						dmaRequest		<= '0';
						bltState			<= bltStSubRead2;
						
					end if;
				
				when bltStSubRead2 =>
				
					if dmaReady = '1' then
							
						bltAccumulator	<= dmaDin;
					
						bltState	<= bltReturnState;
					
					end if;
					
						
				--write accumulator to dest address
				--return to state in bltReturnState
				when bltStSubWrite0 =>
				
					if dmaReady = '1' then
					
						dmaDout							<= bltAccumulator;
						dmaA								<= bltDestAddress;
						dmaRWn							<= '0';
						
						dmaRequest						<= '1';
					
						bltState							<= bltStSubWrite1;
					
					end if;
					
				
				when bltStSubWrite1 =>
				
					if dmaReady = '0' then
					
						dmaRequest		<= '0';
						bltState			<= bltStSubWrite2;
						
					end if;
				
				when bltStSubWrite2 =>
				
					if dmaReady = '1' then
					
						bltState	<= bltReturnState;
					
					end if;


				--read source address 2 and store in accumulator
				--return to state in bltReturnState
				when bltStSubRead2_0 =>
						
						dmaA				<= bltSrcAddress2;
						dmaRWn			<= '1';
						
						dmaRequest		<= '1';
					
						bltState			<= bltStSubRead1;
				
				--write accumulator to dest address if current z is smaller than one in z buffer 
				when bltStSubWriteWithZBuf0 =>
				
					--read z buffer
					dmaA				<= bltGouraudZBufferAddress;
					dmaRWn			<= '1';
						
					dmaRequest		<= '1';
					
					bltState			<= bltStSubWriteWithZBuf1;
					
				when bltStSubWriteWithZBuf1 =>
			
					--dma ack
					if dmaReady = '0' then
					
						dmaRequest		<= '0';
						bltState			<= bltStSubWriteWithZBuf2;
						
					end if;
			
				when bltStSubWriteWithZBuf2 =>
				
					if dmaReady = '1' then
							
						if dmaDin( 15 downto 0 ) < c0itZoutLatched then
				
							--do not write
							bltState	<= bltReturnState;
							
						else
							
							--write new zbuf value
							dmaA									<= bltGouraudZBufferAddress;
							dmaRWn								<= '0';
							dmaDout( 15 downto 0 )			<= c0itZoutLatched;
							
							dmaRequest		<= '1';
						
							bltState			<= bltStSubWriteWithZBuf3;
						
						end if;
					
					end if;
						
				when bltStSubWriteWithZBuf3 =>
				
					--dma ack
					if dmaReady = '0' then
					
						dmaRequest		<= '0';
						bltState			<= bltStSubWriteWithZBuf4;
						
					end if;

				when bltStSubWriteWithZBuf4 =>
					
					if dmaReady = '1' then
					
						--write pixel
						bltState			<= bltStSubWrite0;
						
					end if;
					
										
				when others =>
				
					bltState <= bltStIdle;
			
			end case; --bltState is
	
		end if; --reset = '1'
	
	end if; --rising_edge( bltClock )


end process;


end behavior;
