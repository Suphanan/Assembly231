;SUPHANAN MUJARIN
;580510640

TITLE   PRINT
.MODEL  SMALL
.STACK  100H
.DATA
   PROMPT_1  DB  'Enter the time in seconds up to 65535 = $'
   PROMPT_2  DB  0DH,0AH,'The time in hh:mm:ss format is =$'
   SEPARATOR DB  ' : $'

.CODE
MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, PROMPT_1             ; load and display the string PROMPT_1
     MOV AH, 9
     INT 21H

     CALL INDEC                   ; call the procedure INDEC

     PUSH AX                      ; puah AX onto the STACK

     LEA DX, PROMPT_2             ; load and display the string PROMPT_2
     MOV AH, 9
     INT 21H

     POP AX                       ; pop a value from STACK into AX

     XOR DX, DX                   ; clear DX
     MOV CX, 3600                 ; set CX=3600
     DIV CX                       ; set AX=DX:AX\CX , DX=DX:AX%CX

     CMP AX, 10                   ; compare AX with 10
     JGE @HOURS                   ; jump to label @HOURS if AX>=10

     PUSH AX                      ; push AX onto the STACK

     MOV AX, 0                    ; set AX=0
     CALL OUTDEC                  ; call the procedure OUTDEC

     POP AX                       ; pop a value from STACK into AX
                                   
     @HOURS:                      ; jump label
     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV AX, DX                   ; set AX=DX

     PUSH AX                      ; push AX onto the STACK

     LEA DX, SEPARATOR            ; load and display the string SEPARATOR
     MOV AH, 9
     INT 21H

     POP AX                       ; pop a value from STACK into AX
     XOR DX, DX                   ; clear DX

     MOV CX, 60                   ; set CX=60
     DIV CX                       ; set AX=DX:AX\CX , DX=DX:AX%CX

     CMP AX, 10                   ; compare AX with 10
     JGE @MINUTES                 ; jump to label @MINUTES if AX>=10

     PUSH AX                      ; push AX onto the STACK

     MOV AX, 0                    ; set AX=0
     CALL OUTDEC                  ; call the procedure OUTDEC

     POP AX                       ; pop a value from STACK into AX

     @MINUTES:                    ; jump label
     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV BX, DX                   ; set BX=DX

     LEA DX, SEPARATOR            ; load and display the string SEPARATOR
     MOV AH, 9
     INT 21H

     MOV AX, BX                   ; set AX=BX

     CMP AX, 10                   ; compare AX with 10 
     JGE @SECONDS                 ; jump to label @SECONDS if AX>=10

     PUSH AX                      ; push AX onto the STACK 

     MOV AX, 0                    ; set AX=0
     CALL OUTDEC                  ; call the procedure OUTDEC

     POP AX                       ; pop a value from STACK into AX

     @SECONDS:                    ; jump label
     CALL OUTDEC                  ; call the procedur
    
END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
INCLUDE INDEC.ASM   ; include INDEC
    END MAIN