dosseg
.model small 
.data
error1 db 10,13,"error you enterd a character",10,13,"$" 
error2 db 10,13,"error you divided by zero ",10,13,"$"
error3 db 10,13,"error you did not enterd any number ",10,13,"$"
error4 db 10,13,"error you enter an number more than 16 bit ",10,13,"$"
msg db 10,13,"enter first  multi digit number : $"
msg1 db 10,13,"enter second  multi digit number : $"
msg2 db 10,13,"enter the opration (+,-,*,/) : $"
msg3 db 10,13,"you entered invalid opration.",10,13,"$"
resultmsg db 10,13,"the result is: $"
signmsg  db "- $"
num1 dw 0
num2 dw 0
count db 0
count1 db 0
operation db 0
result dw 0 
remainder dw 0
mulresult dw 0
sign db 0
.code 
main:
mov ax,@data
mov ds,ax

jmp start
nonum1:
mov count,0
mov ah,9
mov dx,offset error1
int 21h

jmp start

nonum2:
mov count,0
mov ah,9
mov dx,offset error2
int 21h
jmp start

jmp start

nonum12:
mov count,0
mov ah,9
mov dx,offset error4
int 21h
jmp start

nonum3:
mov count,0
mov ah,9
mov dx,offset error3
int 21h

start:
mov count,0
mov num1,0
mov ah,9
mov dx,offset msg
int 21h
mov dx,0
again1:
mov ah,1
int 21h
cmp al,13 
je ex1
inc count 
mov cl,al
cmp cl,3ah
jae nonum1
and cl,0f0h
cmp cl,30h
jne nonum1
mov cl,al
mov ch,0
sub cx,30h
mov bx,10
mov ax,num1
mul bx
cmp dx,1
jae nonum12
mov num1,ax
add num1,cx
jmp again1

ex1:
cmp count,0 
je nonum3

jmp again4
again3:
mov ah,9
mov dx,offset msg3
int 21h

again4:
mov ah,9
mov dx,offset msg2
int 21h

mov ah,1
int 21h
cmp al,2ah
je multiplecation
cmp al,2fh
je divition
cmp al,2bh
je additon
cmp al,2dh
je subtration


jmp again3


jmp start1
subtration:
mov operation,2dh
jmp start1
multiplecation:
mov operation,2ah
jmp start1
additon:
mov operation,2bh
jmp start1
divition:
mov operation,2fh







jmp start1


nonum122:
mov count,0
mov ah,9
mov dx,offset error4
int 21h

jmp start1

jmp start1

nonum4:
mov count,0
mov ah,9
mov dx,offset error1
int 21h

jmp start1

nonum5:
mov count,0
mov ah,9
mov dx,offset error2
int 21h
jmp start1

nonum6:
mov count1,0
mov ah,9
mov dx,offset error3
int 21h

start1:
mov count1,0
mov num2,0
mov ah,9
mov dx,offset msg1
int 21h
mov dx,0
again2:
mov ah,1
int 21h
cmp al,13 
je ex2
inc count1
mov cl,al
and cl,0f0h
cmp cl,30h
jne nonum4
mov cl,al
mov ch,0
sub cx,30h
mov bx,10
mov ax,num2
mul bx
cmp dx,1
jae nonum122
mov num2,ax
add num2,cx

jmp again2

ex2:
cmp count1,0 
je nonum6
cmp operation,2fh
jne jump
cmp num2,0
je nonum5
jump:








cmp operation,2dh
je subtrationoperation


cmp operation,2ah
je multiplecationoration

cmp operation,2bh
je additonopration

cmp operation,2fh
je divitionopration


subtrationoperation:
mov ax,num1
sub ax,num2
jnc next
mov sign,1
next:
mov result,ax

jmp printtheresultaddsub

additonopration:
mov ax,num1
add ax,num2
mov result,ax

jmp printtheresultaddsub

divitionopration:

mov bx,num2
mov dx,0
mov ax,num1
div bx
mov result,ax
mov remainder,dx




jmp printtheresultfordiv

multiplecationoration:


mov bx,num2
mov dx,0
mov ax,num1
mul bx
mov result,ax
mov mulresult,dx
jmp printtheresultformul


printtheresultfordiv:
mov ah,9
mov dx,offset resultmsg
int 21h

mov cl,0
l1:
mov ax,result
mov dx,0
mov bx,10
div bx
push dx
inc cl
mov result,ax
cmp ax,0
jne l1

l2:
pop dx 
mov ah,2
add dl,30h
int 21h
dec cl
jnz l2

mov ah,2
mov dl,'.'
int 21h

mov cl,0
l4:
mov ax,remainder
mov bx,10
mov dx,0
div bx
push dx
inc cl
mov result,ax
cmp ax,0
jne l4

l3:
pop dx 
mov ah,2
add dl,30h
int 21h
dec cl
jnz l3






jmp endprogram

printtheresultformul:

mov ah,9
mov dx,offset resultmsg
int 21h


mov cl,0
l47:
mov ax,result
mov bx,10
mov dx,0
div bx
push dx
inc cl
mov result,ax
cmp ax,0
jne l47

l37:
pop dx 
mov ah,2
add dl,30h
int 21h
dec cl
jnz l37

jmp endprogram

printtheresultaddsub:
mov ah,9
mov dx,offset resultmsg
int 21h
cmp sign,1
jne nextt
xor result,0ffffh
add result,1
mov ah,9
mov dx,offset signmsg
int 21h
nextt:

mov cl,0
l31:
mov ax,result
mov bx,10
mov dx,0
div bx
push dx
inc cl
mov result,ax
cmp ax,0
jne l31

l10:
pop dx 
mov ah,2
add dl,30h
int 21h
dec cl
jnz l10






endprogram:

mov ah,4ch
int 21h
end main
