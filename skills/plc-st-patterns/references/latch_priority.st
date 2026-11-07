/// Start/stop latch: stop has priority over start.
FUNCTION_BLOCK FB_LatchPriority
VAR_INPUT
	/// Start request
	Start : BOOL;
	/// TRUE = running allowed; FALSE stops, also on a broken wire
	StopOk : BOOL;
END_VAR
VAR_OUTPUT
	/// The output is on
	Running : BOOL;
END_VAR
// --- implementation ---
Running := StopOk AND (Start OR Running);
