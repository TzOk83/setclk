org 100h
      mov   ah,62h     ; get PSP address
      int   21h
      mov   es,bx
      mov   cl,es:80h  ; read number of parameters supplied
      test  cl,cl
      jz    usage      ; no parameters were supplied
      cmp   cl,02h
      jne   usage      ; more than one parameters were supplied

      mov   ch,es:82h  ; read first parameter from PSP
      cmp   ch,'4'
      je    set477     ; if parameter was 4, go to set477
      cmp   ch,'7'
      je    set715     ; if parameter was 7, go to set715
      cmp   ch,'9'
      je    set954     ; if parameter was 9, go to set954
      jmp   usage      ; else display usage instructions
      
set477: 
      lea   dx,s477    ; load a confirmation message
      mov   cl,021h    ; FE2010 configuration register = 00100001
      jmp   setok

set715: 
      lea   dx,s715    ; load a confirmation message
      mov   cl,061h    ; FE2010 configuration register = 01100001
      jmp   setok

set954:
      lea   dx,s954    ; load a confirmation message
      mov   cl,0a1h    ; FE2010 configuration register = 10100001
      jmp   setok
      
setok:
      int   11h        ; get BIOS equipment list
      test  al, 02h    ; check if FPU is present
      jz    nofpu
      or    cl,02h     ; set FPU flag in FE2010 config register
nofpu:
      mov   al,cl
      out   63h,al     ; send configuration register to port 63h
      jmp   print
      
usage:
      lea   dx,susa    ; load usage information message  

print:                 ; display previously prepared message
      mov   ah,9
      int   21h

exit:
      mov   ax,4C00h   ; exit to DOS
      int   21h

susa  DB "Sets a CPU clock on FE2010A and PT8010AF based PC/XT clones.",0dh,0ah,0ah
      DB "Usage: setclk 4|7|9",0dh,0ah,"$"
s477  DB "CPU clock set to 4.77MHz",0dh,0ah,"$"
s715  DB "CPU clock set to 7.15MHz",0dh,0ah,"$"
s954  DB "CPU clock set to 9.54MHz",0dh,0ah,"$"