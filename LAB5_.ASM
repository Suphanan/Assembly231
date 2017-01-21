model small
.stack 100H
.data

hexnumber db 10,13,'Enter a hex digit: $'
continue db 10,13,'Do you want to continue?: $'
errormsg db 10,13,'Illegal character, Enter 0..9 or A..F: $'
decimalnumber db 10,13,'In decimal it is: $'

.code
MAIN PROC
mov ax,@data
mov ds,ax

continue:      ; start of loop
mov ah,9
mov dx,offset hexnumber
int 21h
mov ah,1
int 21h
mov cl,al

legal:   ;Compare input to see if its less than 30H and 41H and if its greater 
;than 39H and 46H
cmp cl,30h   ;cl < 30h
jl  end_if   ;yes, error msg


cmp cl,46h   ;compare cl >46h
jg  end_if   ;yes, error msg

jmp finally

end_if:          ;If the input is less than 30H or 
;greater than 46H then an error will be displayed
;and the user will have to reenter a hex number.

mov ah,9
lea dx,errormsg ; print error message
int 21h





jmp continue; reenter a hex number





jmp legal  ; jump back to test

finally:        




; determine if number ; 0..9 and display
mov ah,9
lea dx,decimalnumber ; display decimalnumber
int 21h

mov ah,2
mov dl,cl    ;display number          
int 21h



; determine if number a..f and display

mov ah,9 
lea dx,decimalnumber  ; display decimalnumber
int 21h

mov ah,2
mov dl,cl  ; display MSB for 'A' to ;'F'              
int 21h

mov ah,2
sub cl,11H       ; display LSB for 'A' to 'F'     
int 21h



mov ah,9
lea dx,continue     ; display continue message
int 21h

mov ah,1
int 21h
mov bl,al
cmp bl,'Y'           ;bl = Y
jne eoj              ;no, end

je continue          ;yes, loop back to top


eoj:   ;return to DOS prompt
mov ah,4ch
int 21h

main endp
end MAIN


