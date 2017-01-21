TITLE   CLASS AVERAGE
.MODEL  SMALL
.STACK  100H
.DATA
FIVE    DW  5
SCORES  DW  67, 45, 98, 33  ; Mary Allen
    DW  70, 56, 87, 44  ; Scott Baylis
    DW  82, 72, 89, 40  ; George Frank
    DW  80, 67, 95, 50  ; Beth Harris
    DW  78, 76, 92, 60  ; Sam Wong
AVG DW  5 DUP (0)
.CODE   
MAIN    PROC
    MOV AX, @DATA   ; initialize DS
    MOV DS, AX
; j = 4
    MOV SI, 6       ; col index, initially col4
REPEAT:
    MOV CX, 5       ; no. of rows
    XOR BX, BX      ; row index, initially 0
    XOR AX, AX      ; col_sum, initially 0
; sum scores in column j
FOR:
    ADD AX, SCORES[BX + SI]  ; row_sum = row_sum + score
    ADD BX, 8       ; index next row
    LOOP    FOR     ; keep adding scores
; endfor
; compute average in column j
    XOR DX, DX      ; clear high part of divnd
    DIV FIVE        ; AX = average
    MOV AVG[SI], AX ; store in array
    SUB SI, 2       ; go to next column
    ;until j = 0
    JNL REPEAT      ; unless SI < 0

    MOV SI,0
    MOV BX,0
    MOV CX,4
PRINT:
    MOV AX,AVG[SI+BX]
    CALL OUTDEC
    ADD BX,1
    LOOP PRINT

END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
;INCLUDE INDEC.ASM   ; include INDEC
    END MAIN


TITLE   CLASS AVERAGE
.MODEL  SMALL
.STACK  100H
.DATA
FOUR    DB  4
CLASS   DB  'Scott Baylis',70, 56, 87, 44  
        DB  'George Frank',82, 72, 89, 40  
        DB  'Beth Harris ',80, 67, 95, 50  
        DB  'Sam Wong    ',78, 76, 92, 60 
AVG DW  5 DUP (0)
.CODE   
MAIN    PROC
    MOV AX, @DATA   ; initialize DS
    MOV DS, AX
; j = 12
    MOV SI, 12       ; col index, initially col12
REPEAT:
    MOV CX, 4       
    XOR BX, BX      ; row index, initially 0
    XOR AX, AX      ; col_sum, initially 0
; sum scores in row j

FOR_:
    MOV AL,CLASS[BX + SI]
    MOV AH,0
    CALL OUTDEC
    ADD AX, CLASS[BX + SI]  ; row_sum = row_sum + score
    ADD BX, 1       ; index next row
    LOOP    FOR_     ; keep adding scores
; endfor

; compute average in row j
    XOR DX, DX      ; clear high part of divnd
    DIV FOUR        ; AX = average
    MOV AVG[SI], AX ; store in array
    CALL OUTDEC
    ADD SI, 16      ; go to next row
    CMP SI,60
    ;until j = 0
    JNL REPEAT      ; unless SI < 64
    
END_:
    MOV AH, 4CH     ; DOS exit function
    INT 21H         ; exit to DOS

MAIN    ENDP
INCLUDE OUTDEC.ASM  ; include OUTDEC
;INCLUDE INDEC.ASM   ; include INDEC
    END MAIN