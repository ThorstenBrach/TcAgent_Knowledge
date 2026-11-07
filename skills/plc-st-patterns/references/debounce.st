/// Debounces an input: the output follows only after the input was stable for the set time.
FUNCTION_BLOCK FB_Debounce
VAR_INPUT
	/// Raw input
	Raw : BOOL;
	/// How long the input must be stable
	Delay : TIME;
END_VAR
VAR_OUTPUT
	/// Debounced value
	Stable : BOOL;
END_VAR
VAR
	_on : TON;
	_off : TON;
END_VAR
// --- implementation ---
_on(IN := Raw, PT := Delay);
_off(IN := NOT Raw, PT := Delay);
IF _on.Q THEN
	Stable := TRUE;
ELSIF _off.Q THEN
	Stable := FALSE;
END_IF
