OUTDEC	PROC
; prints AX as a signed decimal integer
; input: AX
; output: none
	PUSH	AX		;save registers
	PUSH	BX
	PUSH	CX
	PUSH	DX
; if AX < 0
	CMP	AX, 0		; AX < 0?
	JGE	@END_IF1	; no, > 0
; then
	PUSH	AX		; save number
	MOV	DL, '-'		; get '-'
	MOV	AH, 2		; print char function
	INT	21H		; print '-'
	POP	AX		; get AX back
	NEG	AX		; AX = -AX
@END_IF1:
; get decimal digits
	MOV	CX, 0		; CX counts digits
	MOV	BX, 10D		; BX has divisor
@REPEAT1:
	MOV	DX, 0		; prepare high word of dividend
	DIV	BX		; AX = quotient, DX = remainder
	PUSH	DX		; save remainder on stack
	INC	CX		; count = count + 1
; until
	CMP	AX, 0		; quotient = 0 ?
	JNE	@REPEAT1	; no, keep going
; convert digits to characters and print
	MOV	AH, 2		; print char fucntion
; for count times do
@PRINT_LOOP:
	POP	DX		; digit in DL
	ADD	DL, 30H		; convert to character
	INT	21H		; print digit
	LOOP	@PRINT_LOOP	; loop until done
; end_for
	POP	DX		; restore registers
	POP	CX
	POP	BX
	POP	AX
	RET
OUTDEC	ENDP
