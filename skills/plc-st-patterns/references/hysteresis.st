/// Two-point control: on below Low, off above High, between them the state stays.
FUNCTION_BLOCK FB_Hysteresis
VAR_INPUT
	/// Measured value
	Value : LREAL;
	/// Switch on below this value
	Low : LREAL;
	/// Switch off above this value
	High : LREAL;
	/// FALSE switches off at once
	Enable : BOOL;
END_VAR
VAR_OUTPUT
	/// The output is on
	Active : BOOL;
	/// Low is not below High: the output stays off
	ConfigError : BOOL;
END_VAR
// --- implementation ---
ConfigError := Low >= High;
IF NOT Enable OR ConfigError THEN
	Active := FALSE;
ELSIF Value < Low THEN
	Active := TRUE;
ELSIF Value > High THEN
	Active := FALSE;
END_IF
