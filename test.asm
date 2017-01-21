TITLE   CLASS AVERAGE
.MODEL SMALL
.STACK 100H

.DATA
PROMPT_1   DB  'The Class Marks are as follows : ',0DH,0AH,'$'
PROMPT_2   DB  0DH,0AH,'The Average Marks of Students are as follows : ',0DH,0AH,'$'

AVERAGE  DB  4 DUP(0)
CLASS   DB  'Mary Allen  ',67,45,98,33
        DB  'Scott Baylis',70,56,87,44
        DB  'George Frank',82,72,89,40
        DB  'Sam Wong    ',78,76,92,60 

.CODE
MAIN PROC
    MOV AX, @DATA                ; initialize DS
    MOV DS, AX

    ;LEA DX, PROMPT_1             ; load and print the string ;PROMPT_1
    ;MOV AH, 9
    ;INT 21H
 
    LEA SI, CLASS                ; set SI=offset address of variable CLASS
    MOV BH, 4                    ; set BH=4
    MOV BL, 16                   ; set BL=16

    LEA DI, AVERAGE              ; set DI=offset address of variable AVERAGE
    LEA SI, CLASS                ; set SI=offset address of variable CLASS 
    ADD SI, 12                   ; set SI=SI+12
    MOV CX, 4                    ; set CX=4

COMPUTE_AVERAGE:            ; loop label
    XOR AX, AX                 ; clear AX
    MOV DX, 4                  ; set DX=4

SUM:                      ; loop label
    XOR BH, BH               ; clear BH
    MOV BL, [SI]             ; set BL=[SI]

    ADD AX, BX               ; set AX=AX+BX

    INC SI                   ; set SI=SI+1
    DEC DX                   ; set DX=DX-1
    JNZ SUM                   ; jump to label @SUM if DX!=0

    MOV BX, 4                  ; set BX=4
    DIV BX                     ; set AX=DX:AX/BX , DX=DX:AX%BX

    MOV [DI], AX               ; set [DI]=AX
    ADD DI, 2                  ; set DI=DI+2
    ADD SI, 12                 ; set SI=SI+12
    LOOP COMPUTE_AVERAGE        ; jump to label @COMPUTE_AVERAGE while CX!=0

    LEA DX, PROMPT_2             ; load and print the string PROMPT_2
    MOV AH, 9                     
    INT 21H

    LEA SI, AVERAGE              ; set SI=offset address of variable AVERAGE
    LEA DI, CLASS                ; set DI=offset address of variable CLASS
    MOV CX, 4                    ; set CX=4

RESULT:               ; loop label
    MOV BX, 12                 ; set BX=12
    MOV AH, 2                  ; set output function

NAME:                     ; loop label
    MOV DL, [DI]             ; set DL=[DI]
    INT 21H                  ; print a character

    INC DI                   ; set DI=DI+1
    DEC BX                   ; set BX=BX-1
    JNZ NAME                  ; jump to label @NAME if BX!=0

    MOV DL, 20H                ; set DL=20H
    INT 21H                    ; print a character

    MOV DL, ":"                ; set DL=":"
    INT 21H                    ; print a character

    MOV DL, 20H                ; set DL=20H
    INT 21H                    ; print a character

    XOR AH, AH                 ; clear AH
    MOV AL, [SI]               ; set AL=[SI]

    CALL OUTDEC                ; call the procedure OUTDEC

    MOV AH, 2                  ; set output function
    MOV DL, 0DH                ; carriage return
    INT 21H                    

    MOV DL, 0AH                ; line feed
    INT 21H

    ADD SI, 2                  ; set SI=SI+2
    ADD DI, 4                  ; set DI=DI+4
    LOOP RESULT           ; jump to label @PRINT_RESULT while CX!=0

END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
;INCLUDE INDEC.ASM   ; include INDEC
    END MAIN