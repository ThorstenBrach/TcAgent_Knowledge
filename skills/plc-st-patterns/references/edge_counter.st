/// Counts rising edges up to MaxCount; Reset has priority.
FUNCTION_BLOCK FB_EdgeCounter
VAR_INPUT
	/// Counted signal
	Pulse : BOOL;
	/// Sets the count to 0
	Reset : BOOL;
	/// Count at which Reached becomes TRUE (not "Limit": LIMIT is a standard function)
	MaxCount : UDINT;
END_VAR
VAR_OUTPUT
	/// Current count
	Count : UDINT;
	/// Count has reached MaxCount
	Reached : BOOL;
END_VAR
VAR
	_edge : R_TRIG;
END_VAR
// --- implementation ---
_edge(CLK := Pulse);
IF Reset THEN
	Count := 0;
ELSIF _edge.Q AND (Count < MaxCount) THEN
	Count := Count + 1;
END_IF
Reached := Count >= MaxCount;
