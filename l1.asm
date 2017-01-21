;SUPHANAN MUJARIN
;580510640

TITLE   PRINT
.MODEL  SMALL
.STACK  100H
.DATA
CR  EQU 0DH
LF  EQU 0AH
INPUT DB  CR,LF,'ENTER TIME IN SECONDS: $'
MSG1 DB ' HOUR : $'
MSG2 DB ' MINUTE : $'
MSG3 DB ' SECOND $'
HR  DW  ?
MIN DW  ?
SEC DW  ?

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

    MOV DX,0
    MOV BX,3600
    DIV BX
    MOV HR,AX
    ;CALL OUTDEC

    MOV BX,3600
    MUL BX
    MOV BX,AX
    POP AX
    SUB AX,BX
    PUSH AX

    MOV BX,60
    DIV BX
    MOV MIN,AX
    MOV AX,MIN
    ;CALL OUTDEC
    
    MOV BX,60
    MUL BX
    MOV BX,AX
    POP AX
    SUB AX,BX
    MOV SEC,AX
    ;CALL OUTDEC
   
    MOV AX,HR
    CALL OUTDEC
    LEA DX, MSG1         
    MOV AH, 9
    INT 21H

  
    MOV AX,MIN
    CALL OUTDEC
    LEA DX, MSG2            
    MOV AH, 9
    INT 21H


    MOV AX,SEC
    CALL OUTDEC
    LEA DX, MSG3           
    MOV AH, 9
    INT 21H

   
END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
INCLUDE INDEC.ASM   ; include INDEC
    END MAIN