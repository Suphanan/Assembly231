;SUPHANAN MUJARIN 580510640
TITLE  PROGRAM
.MODEL SMALL
.STACK 100H
.DATA
R1 DB ?
R2 DB ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS, AX
;display promt
    MOV AH, 2
    MOV DL, '?'
    INT 21H

;input 1 
    MOV AH, 1
    INT 21H
    MOV R1,AL

;input 2
    MOV AH, 1
    INT 21H
    MOV R2,AL

;if R1<=R2
    MOV AL,R2
    CMP R1,AL
    MOV AH, 2
    JNBE ELSE_
;Line feed
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL,0AH
    INT 21H
;Then
    MOV DL,R1
    INT 21H
    MOV DL,R2
    JMP DISPLAY 

ELSE_:
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    MOV DL,R2
    INT 21H
    MOV DL,R1
    JMP DISPLAY 

DISPLAY:
    INT 21H

;DOS Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN



