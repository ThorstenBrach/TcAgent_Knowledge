/// Step sequence with a timeout per step and an error state that every step can reach.
FUNCTION_BLOCK FB_TimedSequence
VAR_INPUT
	/// Starts the sequence from Idle
	Start : BOOL;
	/// Acknowledges an error
	Reset : BOOL;
	/// Feedback: position reached
	AtWork : BOOL;
	/// Feedback: back in the start position
	AtHome : BOOL;
	/// Longest time per step
	StepTimeout : TIME;
END_VAR
VAR_OUTPUT
	/// Drive to the work position
	MoveToWork : BOOL;
	/// Drive back
	MoveToHome : BOOL;
	/// Sequence has stopped with an error
	Error : BOOL;
	/// Current step, for diagnosis
	Step : INT;
END_VAR
VAR
	_timer : TON;
	_lastStep : INT;
END_VAR
VAR CONSTANT
	STEP_IDLE : INT := 0;
	STEP_TO_WORK : INT := 10;
	STEP_TO_HOME : INT := 20;
	STEP_ERROR : INT := 900;
END_VAR
// --- implementation ---
// the timer runs anew in every step
_timer(IN := (Step = _lastStep) AND (Step <> STEP_IDLE) AND (Step <> STEP_ERROR), PT := StepTimeout);
_lastStep := Step;
MoveToWork := FALSE;
MoveToHome := FALSE;

CASE Step OF
	STEP_IDLE:
		IF Start THEN
			Step := STEP_TO_WORK;
		END_IF

	STEP_TO_WORK:
		MoveToWork := TRUE;
		IF AtWork THEN
			Step := STEP_TO_HOME;
		ELSIF _timer.Q THEN
			Step := STEP_ERROR;
		END_IF

	STEP_TO_HOME:
		MoveToHome := TRUE;
		IF AtHome THEN
			Step := STEP_IDLE;
		ELSIF _timer.Q THEN
			Step := STEP_ERROR;
		END_IF

	STEP_ERROR:
		IF Reset THEN
			Step := STEP_IDLE;
		END_IF

ELSE
	Step := STEP_ERROR;
END_CASE

Error := Step = STEP_ERROR;
