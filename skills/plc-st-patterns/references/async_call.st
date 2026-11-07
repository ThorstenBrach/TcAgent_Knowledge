/// Drives an asynchronous job with Execute, Busy, Done and Error: one edge per job, the result is kept until the next start.
/// Connect Execute to the block that does the job, and feed its Busy and Error back.
FUNCTION_BLOCK FB_AsyncCall
VAR_INPUT
	/// Starts a job on a rising edge
	Start : BOOL;
	/// Busy output of the called block
	JobBusy : BOOL;
	/// Error output of the called block
	JobError : BOOL;
	/// Longest time for a job
	Timeout : TIME;
END_VAR
VAR_OUTPUT
	/// To the Execute input of the called block
	Execute : BOOL;
	/// Job finished without an error
	Done : BOOL;
	/// Job failed or took too long
	Error : BOOL;
END_VAR
VAR
	_edge : R_TRIG;
	_timer : TON;
	_state : INT;
END_VAR
VAR CONSTANT
	STATE_IDLE : INT := 0;
	STATE_START : INT := 10;
	STATE_WAIT : INT := 20;
END_VAR
// --- implementation ---
_edge(CLK := Start);
_timer(IN := _state <> STATE_IDLE, PT := Timeout);

CASE _state OF
	STATE_IDLE:
		Execute := FALSE;
		IF _edge.Q THEN
			Done := FALSE;
			Error := FALSE;
			Execute := TRUE;
			_state := STATE_START;
		END_IF

	STATE_START:
		// the block needs one call with Execute before Busy can rise
		IF JobBusy THEN
			_state := STATE_WAIT;
		ELSIF JobError THEN
			Error := TRUE;
			_state := STATE_IDLE;
		ELSIF _timer.Q THEN
			Error := TRUE;
			_state := STATE_IDLE;
		END_IF

	STATE_WAIT:
		IF NOT JobBusy THEN
			Done := NOT JobError;
			Error := JobError;
			_state := STATE_IDLE;
		ELSIF _timer.Q THEN
			Error := TRUE;
			_state := STATE_IDLE;
		END_IF

ELSE
	Error := TRUE;
	_state := STATE_IDLE;
END_CASE
