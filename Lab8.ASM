;580510640
;SUPHANAN MUJARIN

TITLE   CLASS AVERAGE
.MODEL  SMALL
.STACK  100H
.DATA
FOUR    DB  4
CLASS   DB  'Scott Baylis',70, 56, 87, 44  
        DB  'George Frank',82, 72, 89, 40  
        DB  'Beth Harris ',80, 67, 95, 50  
        DB  'Sam Wong    ',78, 76, 92, 60 
AVG DB  5 DUP (0)

.CODE
MAIN PROC
    MOV AX, @DATA                ; initialize DS
    MOV DS, AX
 
    LEA SI, CLASS                
    MOV BH, 4                    
    MOV BL, 16                   

    LEA DI, AVG              
    LEA SI, CLASS                
    ADD SI, 12                   
    MOV CX, 4                    

AVERAGE:           
    XOR AX, AX                 
    MOV DX, 4                  

SUM:                      
    XOR BH, BH               
    MOV BL, [SI]    
    ADD AX, BX               

    INC SI                   
    DEC DX                   
    JNZ SUM                   
    MOV BX, 4                  
    DIV BX                     

    MOV [DI], AX               
    ADD DI, 2                  
    ADD SI, 12                 
    LOOP AVERAGE         

    LEA SI, AVG              
    LEA DI, CLASS                
    MOV CX, 4                    

RESULT:               
    MOV BX, 12                 
    MOV AH, 2                  

NAME:                     
    MOV DL, [DI]             
    INT 21H                  

    INC DI                   
    DEC BX                   
    JNZ NAME                  

    MOV DL, 20H                
    INT 21H                    

    MOV DL, "="                
    INT 21H                    

    MOV DL, 20H                
    INT 21H                    

    XOR AH, AH                 
    MOV AL, [SI]               

    CALL OUTDEC               

    MOV AH, 2                  
    MOV DL, 0DH                
    INT 21H                    
    MOV DL, 0AH                
    INT 21H

    ADD SI, 2                  
    ADD DI, 4                  
    LOOP RESULT           

END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
;INCLUDE INDEC.ASM   ; include INDEC
    END MAIN