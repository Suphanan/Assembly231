TITLE	DECIMAL I/O
.MODEL	SMALL
.STACK	
.CODE
MAIN	PROC
; input a number
	CALL	INDEC	; number in AX
	PUSH	AX	; save number
; move cursor to a new line
	MOV	AH, 2
	MOV	DL, 0DH
	INT	21H
	MOV	DL, 0AH
	INT	21H
; output the number
	POP	AX	; retrieve number
	CALL	OUTDEC
; dos exit
	MOV	AH, 4CH
	INT	21H
MAIN	ENDP
INCLUDE	OUTDEC.ASM	; include OUTDEC
INCLUDE	INDEC.ASM	; include INDEC
	END	MAIN
