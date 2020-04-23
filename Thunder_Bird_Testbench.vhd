LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Tail_Light_Controller IS
END TB_Tail_Light_Controller;

ARCHITECTURE Testbench_TLC OF TB_Tail_Light_Controller IS

-- Unit Declaration
COMPONENT Thunder_Bird
	PORT
	(
		CLOCK, LEFT_SIGN, RIGHT_SIGN, HAZZARD_SIGN			:	IN		BIT;
		LEFT_C, LEFT_B, LEFT_A, RIGHT_A, RIGHT_B, RIGHT_C	:	OUT	BIT
	);
END COMPONENT;
FOR ALL : Thunder_Bird USE ENTITY work.Thunder_Bird(Tail_Light_Controller);

SIGNAL	LEFT_SIGNAL		:	BIT_VECTOR	(1 TO 84)	:= ('0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','1','1','1','0','0','1','0','1','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0');
SIGNAL	RIGHT_SIGNAL	:	BIT_VECTOR	(1 TO 84)	:= ('0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','1','0','0','0','1','1','1','0','0','1','0','0','0','0','0','0','1','0','1','0','0','0','0','0','0','1','1','1','0','0','0','0','0');
SIGNAL	HAZZARD_SIGNAL	:	BIT_VECTOR	(1 TO 84)	:= ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','1','1','1','0','0','0','1','1','1','0','0','0','0','1','1','1','0','0','0','0','1','1','1','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','1','1','1','0','0');
SIGNAL	LEFT_BUTTON,RIGHT_BUTTON,HAZZARD_BUTTON,L_C,L_B,L_A,R_A,R_B,R_C	:	BIT;
SIGNAL	CLOCK	:	BIT	:= '1';
	
BEGIN

-- Instantiate Unit
	Sign_Lamp	:	Thunder_Bird
		PORT MAP (CLOCK,LEFT_BUTTON,RIGHT_BUTTON,HAZZARD_BUTTON,L_C,L_B,L_A,R_A,R_B,R_C);

-- Clock Set Up
		CLOCK <= NOT CLOCK AFTER 10 ns;

-- Stimulus Process
	SP : PROCESS
	BEGIN
		WAIT FOR 1 ns;
		FOR i IN 1 TO 84 LOOP
			LEFT_BUTTON		<=	LEFT_SIGNAL(i);
			RIGHT_BUTTON	<=	RIGHT_SIGNAL(i);
			HAZZARD_BUTTON	<=	HAZZARD_SIGNAL(i);
			WAIT FOR 20 ns;
		END LOOP;
		WAIT FOR 20 ns;
		WAIT;
	END PROCESS SP;
END Testbench_TLC;

-- Lamp Combination
-- LRH (Left, Right, Hazzard)

-- Initialization
-- 000
-- 000

-- Left 2 round (A, B, C, A, B, C)
-- 100
-- 100
-- 100
-- 100
-- 100
-- 100

-- OFF
-- 000
-- 000

-- Right 2 round (A, B, C, A, B, C)
-- 010
-- 010
-- 010
-- 010
-- 010
-- 010

-- OFF
-- 000
-- 000

-- Hazzard 3 times
-- 001
-- 001
-- 001

-- OFF
-- 000
-- 000

-- Left_A, suddenly Hazzard 3 times
-- 100
-- 001
-- 001
-- 001

-- OFF
-- 000
-- 000

-- Right_A, suddenly Hazzard 3 times
-- 010
-- 001
-- 001
-- 001

-- OFF
-- 000
-- 000

-- Left_B, suddenly Hazzard 3 times
-- 100
-- 100
-- 001
-- 001
-- 001

-- OFF
-- 000
-- 000

-- Right_B, suddenly Hazzard 3 times
-- 010
-- 010
-- 001
-- 001
-- 001

-- OFF
-- 000
-- 000

-- Hazzard, suddenly Left, suddenly Right
-- 001
-- 100
-- 010

-- OFF
-- 000
-- 000

-- Left_A, suddenly Right
-- 100
-- 010
-- 010
-- 010

-- OFF
-- 000
-- 000

-- Right_A, suddenly Left
-- 010
-- 100
-- 100
-- 100

-- OFF
-- 000
-- 000

-- Left, suddenly Right, suddenly Left, suddenly Right, suddenly Hazzard 2 times
-- 100
-- 010
-- 100
-- 010
-- 001
-- 001

-- Left 1 round, Right 1 round, Hazzard 3 times
-- 100
-- 100
-- 100
-- 010
-- 010
-- 010
-- 001
-- 001
-- 001

-- OFF
-- 000
-- 000