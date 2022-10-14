datos segment
     X dw ?

    Rotulo1 db "Este programa simula una replica del juego de Marrakech",10,13,'$'
    Rotulo2 db "El programa despliega una interfaz grafica en modo texto",10,13,'$'
    Rotulo3 db "Tambien utiliza el teclado para ejecutarse y recibir instrucciones",10,13,'$'
    Rotulo4 db " ",10,13,'$'
    Rotulo5 db "Digite alguna de las letras de las opciones para ejecutar una accion",10,13,'$'
    Rotulo6 db "Para salir del programa digite una x minuscula",10,13,'$'
    Rotulo7 db "posteriormente digite cualquier tecla para finalizar por completo",10,13,'$'
    Rotulo8 db "Se creo una nueva partida",10,13,'$'
    Rotulo9 db "Se agrego al jugador 1",10,13,'$'
    Rotulo10 db "Se agrego al jugador 2",10,13,'$'
    Rotulo11 db "Se agrego al jugador 3",10,13,'$'
    Rotulo12 db "Se agrego al jugador 4",10,13,'$'
    Rotulo13 db "Haga su jugada",10,13,'$'
    Rotulo14 db "Digite cualquier tecla si quiere regresar al menu",10,13,'$'
    Rotulo15 db "Digite cualquier tecla para salir del programa",10,13,'$'
    RotXD db "HOLA XD",10,13,'$'

    titulo db "INICIO",0
    ayuda db "A -> AYUDA",0
    acercade db "B -> DESPLEGAR ACERCA DE",0
    nuevapartida db "C -> NUEVA PARTIDA",0
    agregarjugador1 db "D -> AGREGAR JUGADOR 1",0
    agregarjugador2 db "E -> AGREGAR JUGADOR 2",0
    agregarjugador3 db "F -> AGREGAR JUGADOR 3",0
    agregarjugador4 db "G -> AGREGAR JUGADOR 4",0
    jugar db "H -> JUGAR PARTIDA ACTUAL",0

    Fil db 0
    Col db 0
    ColB db 0   ; gris oscuro
    ColF db 22h  ; Amarillo
    dir db 8

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

programa:
         mov ax, 0B800h
         mov es, ax
         xor si, si
         mov al, 219

	MENU
	call PrintMenu

revisartecla:
		;INTERRUPCION DE TECLADO
		MOV AH,01H
		INT 16H
		JZ  auxilio         
            	JMP HAYTECLA
      auxilio:  jmp revisartecla ;HAYTECLA ;salir;JMP DESPLEGAR ; Algor

ALGOR:

           CMP DIR, 0      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE1
           JMP CERO
PREGUNTE1: CMP DIR, 1      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE2
           JMP UNO
PREGUNTE2: CMP DIR, 2      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE3
           JMP DOS
PREGUNTE3: CMP DIR, 3      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE4
           JMP TRES
PREGUNTE4: CMP DIR, 4      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE5
           JMP CUATRO
PREGUNTE5: CMP DIR, 5
           JNE PREGUNTE6
           JMP CINCO
PREGUNTE6: CMP DIR, 6
           JNE PREGUNTE7
           JMP SEIS
PREGUNTE7: CMP DIR, 7
           JNE PREGUNTE8
           JMP SIETE
PREGUNTE8: Jmp salir


CERO:  
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo5
	int 21h
	mov ah, 09h
	lea dx, Rotulo6
	int 21h
	mov ah, 09h
	lea dx, Rotulo7
	int 21h
	mov ah, 09h
	lea dx, Rotulo4
	int 21h
	jmp salir

UNO:   
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo1
	int 21h
	mov ah, 09h
	lea dx, Rotulo2
	int 21h
	mov ah, 09h
	lea dx, Rotulo3
	int 21h
	mov ah, 09h
	lea dx, Rotulo4
	int 21h
	jmp salir

DOS:  
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo8
	int 21h 
	jmp salir

TRES:  
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo9
	int 21h
	jmp salir

CUATRO:
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo10
	int 21h
	jmp salir

CINCO:
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo11
	int 21h
	jmp salir

SEIS:
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo12
	int 21h
	jmp salir

SIETE:
	mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
	int 10h
	mov ah, 09h
	lea dx, Rotulo13
	int 21h
	jmp salir






;PROCESA LA TECLA DE FUNCION EXTENDIDA
HAYTECLA:
		mov ah, 09h
		lea dx, RotXD
		int 21h
		        XOR AH,AH
			INT 16H
			CMP AL,'x'	;Se sale con una x minuscula
			JZ fin
			
			;CMP AL,0
			;JZ REVISE_DIR
			;JMP ALGOR
			
REVISE_DIR:	;CMP AH,47H	;SI ES HOME
		;	JNE S1 
		;	MOV DIR,4
		;	JMP salircambiodir
		;S1:	CMP AH,49H	;SI ES PG UP
		;	JNZ S2
		;	MOV DIR,7
		;	JMP salircambiodir
		;S2:	CMP AH,4FH	;SI ES END
		;	JNZ S3
		;	MOV DIR,5
		;	JMP salircambiodir
		;S3:	CMP AH,51H	;SI ES PG DN
		;	JNZ S4
                ;       MOV DIR,6 
		;	JMP salircambiodir
		S4:	;CMP AH,1C	;SI ES A
			cmp al, 'A'
			JNZ S5
                        MOV DIR,0  
			JMP salircambiodir
		S5:	;CMP AH,32	;SI ES B
			cmp al, 'B'
			JNZ S6
                        MOV DIR,1  
			JMP salircambiodir
		S6:	;CMP AH,21	;SI ES C
			cmp al, 'C'
			JNZ S7
                        MOV DIR,2  
			JMP salircambiodir
		S7:	;CMP AH,23	;SI ES D
			cmp al, 'D'
			JNZ S8
                        MOV DIR,3  
			JMP salircambiodir
                S8:     ;CMP AH,24	;SI ES E
			cmp al, 'E'
			JNZ S9
                        MOV DIR,4  
			JMP salircambiodir
                S9:     ;CMP AH,2B	;SI ES F
			cmp al, 'F'
			JNZ S10
                        MOV DIR,5  
			JMP salircambiodir
                S10:    ;CMP AH,34	;SI ES G
			cmp al, 'G'
			JNZ S11
                        MOV DIR,6 
			JMP salircambiodir
                S11:    ;CMP AH,33	;SI ES H
			cmp al, 'H'
			JNZ S12
                        MOV DIR,7  
			JMP salircambiodir
		S12:
      
     
 salircambiodir:        jmp algor    ; jmp desplegar


salir:
	mov ah, 09h
	lea dx, Rotulo14
	int 21h

	Tecla
	jmp programa
fin:
	mov ah, 09h
	lea dx, Rotulo15
	int 21h

	Tecla
         mov ax, 03h      ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
         int 10h


         mov ax, 4C00h    ; protocolo de finalización del programa.
         int 21h
     
codigo ends

end inicio