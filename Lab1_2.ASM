TITLE   SEPARATE
.MODEL  SMALL
.STACK  100H
.DATA
CR	EQU	0DH
LF	EQU	0AH
MSG DB  ' ENTER THREE INITIALS: $'
C   DB  CR,LF,' '
C1  DB  CR,LF,?
C2  DB  CR,LF,?
C3  DB  ?,'$'

.CODE
MAIN PROC

;intialize DS
    MOV AX,@DATA
    MOV DS,AX

;display prompt
    LEA DX,MSG
    MOV AH,9
    INT 21H

;input a character
    MOV AH,1
    INT 21H
    MOV C1,AL

;input a character
    MOV AH,1
    INT 21H
    MOV C2,AL

;input a character
    MOV AH,1
    INT 21H
    MOV C3,AL

;display output
    LEA DX,C
    MOV AH,9
    INT 21H
  
; return to DOS
    MOV AH, 4CH     ; DOS exit function
    INT 21H     ; exit to DOS
MAIN    ENDP
    END MAIN   




