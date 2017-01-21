;SUPHANAN MUJARIN
;580510640

TITLE   PRINT
.MODEL  SMALL
.STACK  100H
.DATA
CR  EQU 0DH
LF  EQU 0AH
INPUT DB  CR,LF,'ENTER A HEX DIGIT: $' 
ANS DB  CR,LF,'IN DECIMAL IT IS $'
AGAIN DB  CR,LF,'DO YOU WANT TO DO IT AGAIN? $'
WARN DB CR,LF,'ILLEGAL CHARACTER-ENTER 0..9 OR A..F: $' 

.CODE
MAIN    PROC

;intialize DS
    MOV AX,@DATA
    MOV DS,AX

INPUT_:
;display prompt
    LEA DX,INPUT
    MOV AH,9
    INT 21H


;input a character
    MOV AH,1
    INT 21H
    ;MOV R,AL
    MOV BL,AL

CHECK_:

    CMP BL,30H   ;if below 30H isn't zero
    JB WARN_     ;yes,below go warning
    CMP BL,46H   ;if above 46H isn't f
    JA WARN_     ;yes,above go warning 

JMP SHOW_        

WARN_:
    LEA DX,WARN  ;incorrect recieve
    MOV AH,9
    INT 21H
    MOV AH,1     ;get a new recieve
    INT 21H
    MOV BL,AL

    JMP CHECK_    ;check new input again

SHOW_:
    LEA DX,ANS    ;show promt ans in decimal
    MOV AH,9
    INT 21H
    CMP BL,39H
    JG CONVECT_
    MOV AX,BL
    CALL OUTDEC

AGAIN_:
    LEA DX,AGAIN   ; ask do you want to to again?
    MOV AH,9
    INT 21H

    MOV AH,1       ;prepare read
    INT 21H
    CMP AL,'Y'     ;if((char = 'Y') or (char = 'y'))
    JE INPUT_      ;yes,input again
    CMP AL,'y'
    JE INPUT_
    JMP END_       ;no,terminate

CONVECT_:
    SUB BL,55D
    MOV AX,BL
    CALL OUTDEC
    JMP AGAIN_

END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC

    END MAIN
 

 