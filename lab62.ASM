;SUPHANAN MUJARIN
;580510640

TITLE   PRINT
.MODEL  SMALL
.STACK  100H
.DATA
CR  EQU 0DH
LF  EQU 0AH
INPUT DB  'ENTER A NUMBER OF CENTS: $'
MSG1 DB CR,LF,'HALF-DOLLAR = $'
MSG2 DB CR,LF,'QUARTER = $'
MSG3 DB CR,LF,'DIME = $'
MSG4 DB CR,LF,'NICKEL = $'
MSG5 DB CR,LF,'PENNY = $'
HD DB ?
Q DB ?
D DB ?
N DB ?
P DB ?
CENT  DB  ?

.CODE
MAIN    PROC

;intialize DS
    MOV AX,@DATA
    MOV DS,AX

;display prompt
    LEA DX,INPUT
    MOV AH,9
    INT 21H

;input a character
    CALL INDEC
    PUSH AX
    PUSH AX
    PUSH AX
    PUSH AX

;find half-dollar
    MOV BX,50
    CWD
    DIV BX
    MOV HD,AL
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    MOV AX,HD
    CALL OUTDEC

;find quarter   
    POP AX
    MOV BX,25
    CWD
    DIV BX
    MOV Q,AL
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    MOV AX,Q
    CALL OUTDEC

;find dime
    POP AX
    MOV BX,10
    CWD
    DIV BX
    MOV D,AL
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    MOV AX,D
    CALL OUTDEC

;find nickel
    POP AX
    MOV BX,5
    CWD
    DIV BX
    MOV N,AL
    LEA DX,MSG4
    MOV AH,9
    INT 21H
    MOV AX,N
    CALL OUTDEC

;find penny
    POP AX
    MOV BX,1
    CWD
    DIV BX
    MOV P,AL
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    MOV AX,P
    CALL OUTDEC    
    
END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
INCLUDE INDEC.ASM   ; include INDEC
    END MAIN