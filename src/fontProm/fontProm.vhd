--Copyright (C)2014-2023 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: IP file
--Tool Version: V1.9.9 (64-bit)
--Part Number: GW2AR-LV18QN88C8/I7
--Device: GW2AR-18
--Device Version: C
--Created Time: Mon Feb  5 22:01:14 2024

library IEEE;
use IEEE.std_logic_1164.all;

entity fontProm is
    port (
        dout: out std_logic_vector(7 downto 0);
        clk: in std_logic;
        oce: in std_logic;
        ce: in std_logic;
        reset: in std_logic;
        ad: in std_logic_vector(10 downto 0)
    );
end fontProm;

architecture Behavioral of fontProm is

    signal prom_inst_0_dout_w: std_logic_vector(23 downto 0);
    signal gw_gnd: std_logic;
    signal prom_inst_0_AD_i: std_logic_vector(13 downto 0);
    signal prom_inst_0_DO_o: std_logic_vector(31 downto 0);

    --component declaration
    component pROM
        generic (
            READ_MODE: in bit :='0';
            BIT_WIDTH: in integer := 1;
            RESET_MODE: in string := "SYNC";
            INIT_RAM_00: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_01: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_02: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_03: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_04: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_05: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_06: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_07: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_08: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_09: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_10: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_11: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_12: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_13: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_14: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_15: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_16: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_17: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_18: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_19: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_20: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_21: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_22: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_23: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_24: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_25: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_26: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_27: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_28: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_29: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_30: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_31: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_32: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_33: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_34: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_35: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_36: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_37: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_38: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_39: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
        );
        port (
            DO: out std_logic_vector(31 downto 0);
            CLK: in std_logic;
            OCE: in std_logic;
            CE: in std_logic;
            RESET: in std_logic;
            AD: in std_logic_vector(13 downto 0)
        );
    end component;

begin
    gw_gnd <= '0';

    prom_inst_0_AD_i <= ad(10 downto 0) & gw_gnd & gw_gnd & gw_gnd;
    dout(7 downto 0) <= prom_inst_0_DO_o(7 downto 0) ;
    prom_inst_0_dout_w(23 downto 0) <= prom_inst_0_DO_o(31 downto 8) ;

    prom_inst_0: pROM
        generic map (
            READ_MODE => '0',
            BIT_WIDTH => 8,
            RESET_MODE => "SYNC",
            INIT_RAM_00 => X"0010387CFEFEFE6C7EFFE7C3FFDBFF7E7E8199BD81A5817E0000000000000000",
            INIT_RAM_01 => X"0000183C3C1800007C387CFE7C3810107C387CFEFE387C380010387CFE7C3810",
            INIT_RAM_02 => X"78CCCCCC7D0F070FFFC399BDBD99C3FF003C664242663C00FFFFE7C3C3E7FFFF",
            INIT_RAM_03 => X"995A3CE7E73C5A99C0E66763637F637FE0F07030303F333F187E183C6666663C",
            INIT_RAM_04 => X"0066006666666666183C7E18187E3C1800020E3EFE3E0E020080E0F8FEF8E080",
            INIT_RAM_05 => X"FF183C7E187E3C18007E7E7E0000000078CC386C6C38633E001B1B1B7BDBDB7F",
            INIT_RAM_06 => X"00003060FE6030000000180CFE0C180000183C7E1818181800181818187E3C18",
            INIT_RAM_07 => X"0000183C7EFFFF000000FFFF7E3C180000002466FF6624000000FEC0C0C00000",
            INIT_RAM_08 => X"0066FF6666FF6600000000006666660000180018181818000000000000000000",
            INIT_RAM_09 => X"0000000018181800003B666F381C361C00466630186C660000187C063C603E18",
            INIT_RAM_0A => X"000018187E1818000000663CFF3C66000070381818387000000E1C18181C0E00",
            INIT_RAM_0B => X"00406030180C06000018180000000000000000007E0000003018180000000000",
            INIT_RAM_0C => X"003C660C180C7E00007E30180C663C00007E181818381800003C66766E663C00",
            INIT_RAM_0D => X"003030180C067E00003C66667C603C00003C66067C607E00000C7E6C3C1C0C00",
            INIT_RAM_0E => X"3018180018180000001818001818000000380C063E663C00003C66663C663C00",
            INIT_RAM_0F => X"001800180C663C00006030180C18306000007E00007E000000060C1830180C06",
            INIT_RAM_10 => X"003C666060663C00007C66667C667C0000667E66663C1800003E606E6E663C00",
            INIT_RAM_11 => X"003E666E60603E00006060607C607E00007E60607C607E0000786C66666C7800",
            INIT_RAM_12 => X"00666C78786C6600003C660606060600007E181818187E00006666667E666600",
            INIT_RAM_13 => X"003C666666663C0000666E7E7E7666000063636B7F776300007E606060606000",
            INIT_RAM_14 => X"003C06063C603C0000666C7C66667C0000366C6666663C000060607C66667C00",
            INIT_RAM_15 => X"0063777F6B63630000183C6666666600007E6666666666000018181818187E00",
            INIT_RAM_16 => X"001E181818181E00007E6030180C7E00001818183C6666000066663C3C666600",
            INIT_RAM_17 => X"00FF00000000000000000063361C0800007818181818780000060C1830604000",
            INIT_RAM_18 => X"003C6060603C0000007C66667C606000003E663E063C000000000000000C1818",
            INIT_RAM_19 => X"7C063E66663E0000001818183E180E00003C607E663C0000003E66663E060600",
            INIT_RAM_1A => X"00666C786C6060003C06060606000600003C181838001800006666667C606000",
            INIT_RAM_1B => X"003C6666663C000000666666667C000000636B7F7F660000003C181818183800",
            INIT_RAM_1C => X"007C063C603E000000606060667C000006063E66663E000060607C66667C0000",
            INIT_RAM_1D => X"00363E7F6B63000000183C6666660000003E666666660000000E1818187E1800",
            INIT_RAM_1E => X"000E18187018180E007E30180C7E0000780C3E666666000000663C183C660000",
            INIT_RAM_1F => X"0010181C1E1C1810000000000000DC76007018180E1818700018181800181818",
            INIT_RAM_20 => X"003F663E063CC37E0078C0FCCC78001C007ECCCCCC00CC00780C1878CCC0CC78",
            INIT_RAM_21 => X"380C78C0C0780000007ECC7C0C783030007ECC7C0C7800E0007ECC7C0C7800CC",
            INIT_RAM_22 => X"00783030307000CC0078C0FCCC7800E00078C0FCCC7800CC003C607E663CC37E",
            INIT_RAM_23 => X"00CCFCCC7800303000C6C6FEC66C38C600783030307000E0003C18181838C67C",
            INIT_RAM_24 => X"0078CCCC7800CC7800CECCCCFECC6C3E007FCC7F0C7F000000FC607860FC001C",
            INIT_RAM_25 => X"007ECCCCCC00E000007ECCCCCC00CC780078CCCC7800E0000078CCCC7800CC00",
            INIT_RAM_26 => X"18187EC0C07E18180078CCCCCCCC00CC00183C66663C18C3F80C7CCCCC00CC00",
            INIT_RAM_27 => X"70D818183C181B0EC7C6CFC6FACCCCF83030FC30FC78CCCC00FCE660F0646C38",
            INIT_RAM_28 => X"007ECCCCCC001C000078CCCC78001C000078303030700038007ECC7C0C78001C",
            INIT_RAM_29 => X"00007C00386C6C3800007E003E6C6C3C00CCDCFCECCC00FC00CCCCCCF800F800",
            INIT_RAM_2A => X"0FCC6633DECCC6C300000C0CFC0000000000C0C0FC0000000078CCC060300030",
            INIT_RAM_2B => X"0000CC663366CC0000003366CC663300001818181800181803CF6F37DBCCC6C3",
            INIT_RAM_2C => X"1818181818181818EEDB77DBEEDB77DBAA55AA55AA55AA558822882288228822",
            INIT_RAM_2D => X"363636FE00000000363636F636363636181818F818F81818181818F818181818",
            INIT_RAM_2E => X"363636F606FE00003636363636363636363636F606F63636181818F818F80000",
            INIT_RAM_2F => X"181818F800000000000000F818F81818000000FE36363636000000FE06F63636",
            INIT_RAM_30 => X"1818181F18181818181818FF00000000000000FF181818180000001F18181818",
            INIT_RAM_31 => X"36363637363636361818181F181F1818181818FF18181818000000FF00000000",
            INIT_RAM_32 => X"363636F700FF0000000000FF00F7363636363637303F00000000003F30373636",
            INIT_RAM_33 => X"000000FF00FF1818363636F700F73636000000FF00FF00003636363730373636",
            INIT_RAM_34 => X"0000003F36363636363636FF00000000181818FF00FF0000000000FF36363636",
            INIT_RAM_35 => X"363636FF363636363636363F000000001818181F181F00000000001F181F1818",
            INIT_RAM_36 => X"FFFFFFFFFFFFFFFF1818181F00000000000000F818181818181818FF18FF1818",
            INIT_RAM_37 => X"00000000FFFFFFFF0F0F0F0F0F0F0F0FF0F0F0F0F0F0F0F0FFFFFFFF00000000",
            INIT_RAM_38 => X"006C6C6C6C6CFE0000C0C0C0C0CCFC00C0C0F8CCF8CC78000076DCC8DC760000",
            INIT_RAM_39 => X"0018181818DC7600C0607C66666666000070D8D8D87E000000FCCC603060CCFC",
            INIT_RAM_3A => X"0078CCCC7C18301C00EE6C6CC6C66C3800386CC6FEC66C38FC3078CCCC7830FC",
            INIT_RAM_3B => X"00CCCCCCCCCCCC78003860C0F8C06038C0607EDBDB7E0C0600007EDBDB7E0000",
            INIT_RAM_3C => X"00FC00183060301800FC00603018306000FC003030FC30300000FC00FC00FC00",
            INIT_RAM_3D => X"0000DC7600DC760000303000FC00303070D8D8181818181818181818181B1B0E",
            INIT_RAM_3E => X"1C3C6CEC0C0C0C0F0000001800000000000000181800000000000000386C6C38",
            INIT_RAM_3F => X"000000000000000000003C3C3C3C000000000078603018700000006C6C6C6C78"
        )
        port map (
            DO => prom_inst_0_DO_o,
            CLK => clk,
            OCE => oce,
            CE => ce,
            RESET => reset,
            AD => prom_inst_0_AD_i
        );

end Behavioral; --fontProm
