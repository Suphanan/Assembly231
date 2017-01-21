TITLE   SUM
.MODEL  SMALL
.STACK  100H
.CODE
MAIN    PROC
; display prompt
    MOV AH, 2       
    MOV DL, '?'     
    INT 21H   

; input a number1
    MOV AH, 1       
    INT 21H     
    MOV BL, AL

 ; input a number2
    MOV AH, 1       
    INT 21H     

; add 
    ADD BL,AL
    ;ADD CL,BL
    SUB BL,30H
    
; go to a new line
    MOV AH, 2       
    MOV DL, 0DH     
    INT 21H     
    MOV DL, 0AH     
    INT 21H 

; display number
    MOV AH,2    
    MOV DL,BL 
    INT 21H      

 ; return to DOS
    MOV AH, 4CH     ; DOS exit function
    INT 21H     ; exit to DOS
MAIN    ENDP
    END MAIN   