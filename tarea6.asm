datos segment
     X dw ?

    titulo db "INICIO",0
    ayuda db "AYUDA",0
    acercade db "DESPLEGAR ACERCA DE",0
    nuevapartida db "NUEVA PARTIDA",0
    agregarjugador1 db "AGREGAR JUGADOR 1",0
    agregarjugador2 db "AGREGAR JUGADOR 2",0
    agregarjugador3 db "AGREGAR JUGADOR 3",0
    agregarjugador4 db "AGREGAR JUGADOR 4",0
    jugar db "JUGAR PARTIDA ACTUAL",0

    Fil db 0
    Col db 0
    ColB db 0   ; gris oscuro
    ColF db 22h  ; Amarillo

datos ends

azul EQU 00010001b
roja EQU 01000100b
blanca EQU 07Fh
negra EQU 0
amarilla EQU 0Eh
verde EQU 22h
cyan EQU 33h

pila segment stack 'stack'

    dw 256 dup (?)

pila ends


FRANJAV Macro color
local franja1, salir, ciclo

         mov ah, color
         mov dx, N
	 mov si, 88
ciclo:   cmp dx, 0
         jz salir
         mov cx, 25
         franja1:
           mov word ptr es:[si], ax
           add si, 160
         loop franja1
         dec dx
         sub si, 160*25-2
         jmp ciclo
salir:
endM

MENU Macro
   ;N = 44
   ;franjaV negra
   N = 36
   FRANJAV blanca
   ;FRANJAV blanca
   ;FRANJAV roja
   ;N = 1
   ;FRANJAV negra
EndM

Tecla Macro 
   xor ah,ah
   int 16h
EndM



codigo segment

    assume  cs:codigo, ds:datos, ss:pila



PrnRot Proc
; Recibe en el DS:[si] un puntero al rÃ³tulo.  Supone que es un asciiz
; Recibe en el DX la coordenada donde se debe desplegar (DL=Fila y DH=Columna)
; Recibe en el BX el color (BL=Foreground y BH=Background) 

         push ax 
         push bx 
         push cx 
         push dx 
         push di 
         push si 
         push es        

         mov ax, 0B800h        ; pone el ES a apuntar al segmento de video
         mov es, ax 

         mov Al, Dl            ; calcula el desplazamiento en la memoria de video necesario para llegar
         mov cl, 80            ; a la fila y columna solicitada. 
         mul cl                ; es similar a accesar una matriz.
         mov cl, dh
         xor ch, ch
         add ax, cx
         shl ax, 1
         mov di, ax                
         
         mov ah, bl            ; montamos el byte de color.
         and ah,0Fh
         mov cl, 4
         shl bh, cl
         or ah, bh         

cicPrnRot:
         cmp byte ptr [si],0
         je salirprnRot

         mov al, byte ptr [si]      ; copiamos el ascii del rotulo
         mov word ptr Es:[di], ax   ; ponemos en pantalla el caracter con todo y color. 
         inc di                     ; en la pantalla avanzamos de dos en dos
         inc di 
         inc si                     ; en el rotulo de uno en uno
         jmp cicPrnRot

salirprnRot:

        pop es
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        ret 

PrnRot EndP

PrintMenu proc

         push ax 
         push bx 
         push cx 
         push dx 
         push di 
         push si 
         push es   


	 mov byte ptr Fil, 3
	 mov byte ptr Col, 59
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, titulo
         call prnRot

	 mov byte ptr Fil, 7
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, ayuda
         call prnRot

	 mov byte ptr Fil, 9
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, acercade
         call prnRot

	 mov byte ptr Fil, 11
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, nuevapartida
         call prnRot

	 mov byte ptr Fil, 13
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, agregarjugador1
         call prnRot

	 mov byte ptr Fil, 15
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, agregarjugador2
         call prnRot

	 mov byte ptr Fil, 17
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, agregarjugador3
         call prnRot

	 mov byte ptr Fil, 19
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, agregarjugador4
         call prnRot

	 mov byte ptr Fil, 21
	 mov byte ptr Col, 48
         mov dl, Fil
         mov dh, Col
         mov bh, ColB
         mov bl, ColF
         lea si, jugar
         call prnRot

	pop es
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        ret 

PrintMenu endP



                                                                             
 inicio: 

         mov ax, datos   ; protocolo de inicialización del programa.
         mov ds, ax
         mov ax, pila
         mov ss, ax

         mov ax, 0B800h
         mov es, ax
         xor si, si
         mov al, 219

	MENU
	call PrintMenu

	Tecla

         mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
         int 10h


         mov ax, 4C00h    ; protocolo de finalización del programa.
         int 21h
     
codigo ends

end inicio