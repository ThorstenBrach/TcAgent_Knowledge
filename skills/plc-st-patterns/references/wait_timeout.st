/// Waits for a signal with a timeout. Call it every cycle while Enable is TRUE.
FUNCTION_BLOCK FB_WaitTimeout
VAR_INPUT
	/// TRUE while waiting; FALSE resets
	Enable : BOOL;
	/// The awaited signal
	Signal : BOOL;
	/// Longest waiting time
	Timeout : TIME;
END_VAR
VAR_OUTPUT
	/// The signal came in time
	Done : BOOL;
	/// The signal did not come in time
	TimedOut : BOOL;
END_VAR
VAR
	_timer : TON;
END_VAR
// --- implementation ---
_timer(IN := Enable AND NOT Done, PT := Timeout);
IF NOT Enable THEN
	Done := FALSE;
	TimedOut := FALSE;
ELSIF NOT TimedOut THEN
	IF Signal THEN
		Done := TRUE;
	ELSIF _timer.Q THEN
		TimedOut := TRUE;
	END_IF
END_IF
