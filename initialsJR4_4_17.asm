TITLE printing multiline          (mline.asm)
  
INCLUDE Irvine32.inc
;print picture no procedure
.data  

 ;array1 byte 2,'x',6,' ',2,'z' 
; array2 byte 2,' ',2,'x',2,' ',2,'z'
; array3 byte 4,' ',2,'x',5,'w'

array1 byte 1," ",6,"X",2," ",6,"X"
array2 byte 3," ",2,"X",4," ",1,"X",4," ",1,"X"
array3 byte 3," ",2,"X",4," ",5,"X"
array4 byte 1,"X",2," ",2,"X",4," ",1,"X",4," ",1,"X"
array5 byte 5,"X",4," ",1,"X",4," ",1,"X"
 
 ;------------------------------
 ; we wish to output
 ;    xx      zz
 ;      xx  zz
 ;        xxwwwww
 ;------------------------------
COMMENT*          
          XXXXXX  XXXXXX
		  XX    X    X
		  XX    XXXXX
	    X  XX    X    X
	    XXXXX    X    X
	      
*COMMENT
 delta dword ?
 l dword ?
 lenarray1 = lengthof array1
 lenarray2 = lengthof array2
 lenarray3 = lengthof array3
 lenarray4 = lengthof array4
 lenarray5 = lengthof array5

 grandarray dword 12 dup(?) 
 ; grandarray contains the the three offsets and the 3 lengths of the arrays
 .code
main proc
 call clrscr
  
 mov dh,10
 mov dl,5   
 call gotoxy   ;line will start at 10 down 5 across
  
;---------------------------
; fill grandarray using the procedure fill
  call fill

;---------------------------
; loop around 3 times to print each line with drawline
 mov esi,offset grandarray
 sub esi,4   ; we start a dword back
 mov ecx,5
 outer:
   push ecx
   ; get each array from grandarry data
   add esi,4
   mov edi, [esi]
   add esi, 4
   mov ecx, [esi]
   mov l,ecx
   mov ecx, l
   
   inner:
     push ecx     ;use data from eachg line to det up  
     mov ecx,0
     mov   cl, [edi]
      
     inc edi
     mov al,[edi]
     call drawline
     inc edi
      
     pop ecx
   loop inner
   inc dh
    
    
   mov dl,5
   pop ecx
   call gotoxy
  ; call dumpregs
  ; call waitmsg
  loop outer
   exit  
     
main ENDP
drawline proc
     
    lineloop:    
       call writechar
       inc dl
    loop lineloop
    ret
 drawline endp
 
fill proc
; dword array will be of the form 
; off len off len off len
  mov esi,offset grandarray

  mov [esi],offset array1
  add esi,4
  mov ebx, lenarray1/2
  mov [esi],ebx

  add esi,4
  mov [esi],  offset array2
  add esi,4
  mov ebx, lenarray2/2
  mov [esi],ebx

  add esi,4
  mov [esi],  offset array3
  add esi,4
  mov ebx, lenarray3/2
  mov [esi],ebx

  ADD ESI,4
  MOV [ESI], offset array4
  add ESI,4
  MOV EBX, lenarray4/2
  MOV[ESI],EBX
  add ESI,4

  MOV [ESI],offset array5
  add ESI,4
  MOV EBX,lenarray5/2
  MOV[ESI],EBX

  ret
fill endp
 END main