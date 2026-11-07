/// Tracks parts on a conveyor: one position per clock edge, the state of each part travels with it.
FUNCTION_BLOCK FB_ShiftRegister
VAR_INPUT
	/// One edge per position of the conveyor
	Clock : BOOL;
	/// State of the part entering at position 1: 0 = none, 1 = good, 2 = bad
	InState : USINT;
	/// Clears all positions
	Clear : BOOL;
END_VAR
VAR_OUTPUT
	/// State of the part at each position
	Positions : ARRAY[1..LENGTH] OF USINT;
	/// State of the part that left at the last edge
	OutState : USINT;
END_VAR
VAR
	_edge : R_TRIG;
	_index : INT;
END_VAR
VAR CONSTANT
	LENGTH : INT := 8;
END_VAR
// --- implementation ---
_edge(CLK := Clock);
IF Clear THEN
	FOR _index := 1 TO LENGTH DO
		Positions[_index] := 0;
	END_FOR
	OutState := 0;
ELSIF _edge.Q THEN
	OutState := Positions[LENGTH];
	FOR _index := LENGTH TO 2 BY -1 DO
		Positions[_index] := Positions[_index - 1];
	END_FOR
	Positions[1] := InState;
END_IF
