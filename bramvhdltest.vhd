FUNCTION cyclonev_ram_block (clk0, clk1, clr0, clr1, ena0, ena1, ena2, ena3, portaaddr[PORT_A_ADDRESS_WIDTH-1..0], portaaddrstall, portabyteenamasks[PORT_A_BYTE_ENABLE_MASK_WIDTH-1..0], portadatain[PORT_A_DATA_WIDTH-1..0], portare, portawe, portbaddr[PORT_B_ADDRESS_WIDTH-1..0], portbaddrstall, portbbyteenamasks[PORT_B_BYTE_ENABLE_MASK_WIDTH-1..0], portbdatain[PORT_B_DATA_WIDTH-1..0], portbre, portbwe)
WITH ( CLK0_CORE_CLOCK_ENABLE, CLK0_INPUT_CLOCK_ENABLE, CLK0_OUTPUT_CLOCK_ENABLE, CLK1_CORE_CLOCK_ENABLE, CLK1_INPUT_CLOCK_ENABLE, CLK1_OUTPUT_CLOCK_ENABLE, CONNECTIVITY_CHECKING, DATA_INTERLEAVE_OFFSET_IN_BITS, DATA_INTERLEAVE_WIDTH_IN_BITS, DONT_POWER_OPTIMIZE, ENABLE_ECC, INIT_FILE, INIT_FILE_LAYOUT, LOGICAL_RAM_NAME, mem_init0, mem_init1, mem_init10, mem_init11, mem_init12, mem_init13, mem_init14, mem_init15, mem_init16, mem_init17, mem_init18, mem_init19, mem_init2, mem_init20, mem_init21, mem_init22, mem_init23, mem_init24, mem_init25, mem_init26, mem_init27, mem_init28, mem_init29, mem_init3, mem_init30, mem_init31, mem_init32, mem_init33, mem_init34, mem_init35, mem_init36, mem_init37, mem_init38, mem_init39, mem_init4, mem_init40, mem_init41, mem_init42, mem_init43, mem_init44, mem_init45, mem_init46, mem_init47, mem_init48, mem_init49, mem_init5, mem_init50, mem_init51, mem_init52, mem_init53, mem_init54, mem_init55, mem_init56, mem_init57, mem_init58, mem_init59, mem_init6, mem_init60, mem_init61, mem_init62, mem_init63, mem_init64, mem_init65, mem_init66, mem_init67, mem_init68, mem_init69, mem_init7, mem_init70, mem_init71, mem_init8, mem_init9, MIXED_PORT_FEED_THROUGH_MODE, OPERATION_MODE, PORT_A_ADDRESS_CLEAR, PORT_A_ADDRESS_WIDTH = 1, PORT_A_BYTE_ENABLE_MASK_WIDTH = 1, PORT_A_BYTE_SIZE, PORT_A_DATA_OUT_CLEAR, PORT_A_DATA_OUT_CLOCK, PORT_A_DATA_WIDTH = 1, PORT_A_FIRST_ADDRESS, PORT_A_FIRST_BIT_NUMBER, PORT_A_LAST_ADDRESS, PORT_A_LOGICAL_RAM_DEPTH, PORT_A_LOGICAL_RAM_WIDTH, PORT_A_READ_DURING_WRITE_MODE, PORT_B_ADDRESS_CLEAR, PORT_B_ADDRESS_CLOCK, PORT_B_ADDRESS_WIDTH = 1, PORT_B_BYTE_ENABLE_CLOCK, PORT_B_BYTE_ENABLE_MASK_WIDTH = 1, PORT_B_BYTE_SIZE, PORT_B_DATA_IN_CLOCK, PORT_B_DATA_OUT_CLEAR, PORT_B_DATA_OUT_CLOCK, PORT_B_DATA_WIDTH = 1, PORT_B_FIRST_ADDRESS, PORT_B_FIRST_BIT_NUMBER, PORT_B_LAST_ADDRESS, PORT_B_LOGICAL_RAM_DEPTH, PORT_B_LOGICAL_RAM_WIDTH, PORT_B_READ_DURING_WRITE_MODE, PORT_B_READ_ENABLE_CLOCK, PORT_B_WRITE_ENABLE_CLOCK, POWER_UP_UNINITIALIZED, RAM_BLOCK_TYPE, WIDTH_ECCSTATUS = 3)
RETURNS ( dftout[8..0], eccstatus[WIDTH_ECCSTATUS-1..0], portadataout[PORT_A_DATA_WIDTH-1..0], portbdataout[PORT_B_DATA_WIDTH-1..0]);

--synthesis_resources = M10K 1 
OPTIONS ALTERA_INTERNAL_OPTION = "OPTIMIZE_POWER_DURING_SYNTHESIS=NORMAL_COMPILATION";

SUBDESIGN altsyncram_b8s1
( 
	address_a[5..0]	:	input;
	address_b[5..0]	:	input;
	clock0	:	input;
	clock1	:	input;
	clocken1	:	input;
	data_a[7..0]	:	input;
	q_b[7..0]	:	output;
	wren_a	:	input;
) 
VARIABLE 
	ram_block2a0 : cyclonev_ram_block
		WITH (
			CLK0_CORE_CLOCK_ENABLE = "ena0",
			CLK0_INPUT_CLOCK_ENABLE = "none",
			CLK1_CORE_CLOCK_ENABLE = "ena1",
			CLK1_INPUT_CLOCK_ENABLE = "ena1",
			CONNECTIVITY_CHECKING = "OFF",
			LOGICAL_RAM_NAME = "ALTSYNCRAM",
			MIXED_PORT_FEED_THROUGH_MODE = "dont_care",
			OPERATION_MODE = "dual_port",
			PORT_A_ADDRESS_WIDTH = 6,
			PORT_A_DATA_WIDTH = 1,
			PORT_A_FIRST_ADDRESS = 0,
			PORT_A_FIRST_BIT_NUMBER = 0,
			PORT_A_LAST_ADDRESS = 63,
			PORT_A_LOGICAL_RAM_DEPTH = 64,
			PORT_A_LOGICAL_RAM_WIDTH = 8,
			PORT_B_ADDRESS_CLEAR = "none",
			PORT_B_ADDRESS_CLOCK = "clock1",
			PORT_B_ADDRESS_WIDTH = 6,
			PORT_B_DATA_OUT_CLEAR = "none",
			PORT_B_DATA_WIDTH = 1,
			PORT_B_FIRST_ADDRESS = 0,
			PORT_B_FIRST_BIT_NUMBER = 0,
			PORT_B_LAST_ADDRESS = 63,
			PORT_B_LOGICAL_RAM_DEPTH = 64,
			PORT_B_LOGICAL_RAM_WIDTH = 8,
			PORT_B_READ_ENABLE_CLOCK = "clock1",
			RAM_BLOCK_TYPE = "AUTO"
		);