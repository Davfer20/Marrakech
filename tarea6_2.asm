; Instituto Tecnologico de Costa Rica 
; Jose David Fernandez Salas #2022045079 
; Erick Kauffmann Porcar #
; Arquitectura de Computadores IC3101 
; Profesor: Kirstein Gätjens S.
; Tarea Quantik
; Fecha: 16/10/2022

; ------------------------------Manual-Usuario--------------------------------------------------------------------------------------

; ------------------------------Auto-Evaluacion-------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------------------------------------

datos segment
    ;----------------------------Colores----------------------------------------
    azul            EQU 00010001b
    morado          EQU 00011001b
    roja            EQU 01000100b
    blanca          EQU 07Fh
    negra           EQU 0
    amarilla        EQU 0Eh
    verde           EQU 22h
    cyan            EQU 33h
    blue            EQU 1h
  
    ;----------------------------Datos----------------------------------------
    Fil             db  0
    Col             db  0

    ColB            db  0
    ColF            db  22h
    dir             db  8
   
    filasE          db  0
    coluE           db  0
    posE            db  0

    FILBi DB 9
    COLBi DB 23
    DIRBi DB 4
    ASTERIX DB 'v',0AH   ; Fondo negro y arroba verde CLARO
    PAUSA1 dw 1000
    PAUSA2 dw 100 

    direccionAlfombra db ?




    ;----------------------------Rotulos----------------------------------------
    Rotulo1         db  "Este programa simula una replica del juego de Marrakech",0 ;10,13,'$'
    Rotulo2         db  "El programa despliega una interfaz grafica en modo texto",0 ;10,13,'$'
    Rotulo3         db  "Tambien utiliza el teclado para ejecutarse y recibir instrucciones",0 ;10,13,'$'
    Rotulo4         db  "                                                                                ",0 ;10,13,'$'
    Rotulo5         db  "Digite alguna de las letras de las opciones para ejecutar una accion",0 ;10,13,'$'
    Rotulo6         db  "Para salir del programa digite una x minuscula",0 ;10,13,'$'
    Rotulo7         db  "posteriormente digite cualquier tecla para finalizar por completo",0 ;10,13,'$'
    Rotulo8         db  "Se creo una nueva partida",0 ;10,13,'$'
    Rotulo9         db  "Se agrego al jugador 1",0 ;10,13,'$'
    Rotulo10        db  "Se agrego al jugador 2",0 ;10,13,'$'
    Rotulo11        db  "Se agrego al jugador 3",0 ;10,13,'$'
    Rotulo12        db  "Se agrego al jugador 4",0 ;10,13,'$'
    Rotulo13        db  "Haga su jugada, digite i cuando este posicionado en la casilla deseada",0 ;10,13,'$'
    Rotulo14        db  "Digite cualquier tecla si quiere regresar al menu: ",0 ;10,13,'$'
    Rotulo15        db  "Digite cualquier tecla para salir del programa: ",0 ;10,13,'$'
    RotXD           db  "HOLA XD",0 ;10,13,'$'

    errorAlfombraPos db "Ingrese unicamente V o H",0
    
    titulo          db  "INICIO",0
    ayuda           db  "A -> AYUDA",0
    acercade        db  "B -> DESPLEGAR ACERCA DE",0
    nuevapartida    db  "C -> NUEVA PARTIDA",0
    agregarjugador1 db  "D -> AGREGAR JUGADOR 1",0
    agregarjugador2 db  "E -> AGREGAR JUGADOR 2",0
    agregarjugador3 db  "F -> AGREGAR JUGADOR 3",0
    agregarjugador4 db  "G -> AGREGAR JUGADOR 4",0
    jugar           db  "H -> JUGAR PARTIDA ACTUAL",0


    msgFilas        db  "Ingrese la pocicion de filas: ",10,13,"$"
    msgColumnas     db  "Ingrese la pocicion de columnas: ",10,13,"$"
    msgpocision     db  "Ingrese V o H para su pocicion: ",0 ;10,13,"$"


    marco           db  "=======================================",0
    marco2          db  ""
    marco3          db  "-------------oooOO-($$$)-OOooo-----------------",0

    aI              db  "I",0
    aV              db  "║",0
    dIz             db  "╚",0
    ad              db  "╗",0
    ddh             db  "╝",0

    as              db  "*",0

datos endS

pila segment stack 'stack'
         dw 256 dup(?)
pila endS

codigo segment

                   assume         cs:codigo, ds:datos, ss:pila

    ;-------------------Macros-------------------------------

FRANJAV Macro color
                   local          franja1, salir, ciclo

                   mov            ah, color
                   mov            dx, N
                   mov            si, 94
    ciclo:         cmp            dx, 0
                   jz             salir
                   mov            cx, 25
    franja1:       
                   mov            word ptr es:[si], ax
                   add            si, 160
                   loop           franja1
                   dec            dx
                   sub            si, 160*25-2
                   jmp            ciclo
    salir:         
                   endM

franjaH Macro color                                               ;Pone colores
                   local          franja1

                   mov            cx, 80*N
                   mov            ah, color
    franja1:       
                   mov            word ptr es:[si], ax
                   inc            si
                   inc            si
                   loop           franja1
                   endM

bordeP Macro color                                                ;Macro con borde principal
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, blue
                   mov            bl, verde
                   lea            si, marco
                   call           PrnRot
                   endM

marcoArriba Macro color                                           ;Macro con borde
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, azul
                   mov            bl, blanca
                   lea            si, marco3
                   call           PrnRot
                   endM

asteriscoFila Macro color                                         ;Macro con borde
                   mov            bh, azul
                   mov            bl, blanca
                   lea            si, as
                   sub            dl,1
                   lea            si, as
                   call           PrnRot

                   add            dl,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   sub            dl,1
                   call           PrnRot
                   endM

asteriscoFila2 Macro color                                        ;Macro con borde
                   mov            bh, azul
                   mov            bl, blanca
                   lea            si, as
                   sub            dh,1
                   lea            si, as
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dl,1
                   call           PrnRot

                   add            dl,1
                   call           PrnRot

                   sub            dh,1
                   call           PrnRot

                    
                   endM
   
   
asteriscoFila3 Macro color                                        ;Macro con borde
                   mov            bh, azul
                   mov            bl, blanca
                   lea            si, as
                   add            dl,1
                   call           PrnRot

                   sub            dl,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot

                   add            dl,1
                   call           PrnRot

                   endM

asteriscoFila4 Macro color                                        ;Macro con borde
                   mov            bh, azul
                   mov            bl, blanca
                   lea            si, as
                   add            dh,1
                   lea            si, as
                   call           PrnRot

                   sub            dh,1
                   call           PrnRot

                   add            dl,1
                   call           PrnRot

                   add            dl,1
                   call           PrnRot

                   add            dh,1
                   call           PrnRot
                   endM

marcoDesign2 Macro color                                          ;Macro con borde
    ;Parte abajo
                   mov            dl, 17
                   mov            dh, 5
                   asteriscoFila

                   mov            dl, 17
                   mov            dh, 17
                   asteriscoFila

                   mov            dl, 17
                   mov            dh, 29
                   asteriscoFila

                   mov            dl,16
                   mov            dh, 41
                   call           PrnRot

                   mov            dl,17
                   mov            dh, 41
                   call           PrnRot

                   mov            dl,17
                   mov            dh, 42
                   call           PrnRot

                   mov            dl,17
                   mov            dh, 43
                   call           PrnRot

                   mov            dl,17
                   mov            dh, 44
                   call           PrnRot

                   mov            dl,17
                   mov            dh, 45
                   call           PrnRot

                   mov            dl,16
                   mov            dh, 45
                   call           PrnRot

                   mov            dl,15
                   mov            dh, 45
                   call           PrnRot

                   mov            dl,15
                   mov            dh, 44
                   call           PrnRot
    ; ;parte derecha

                   mov            dl, 3
                   mov            dh, 45
                   asteriscoFila2

                   mov            dl, 7
                   mov            dh, 45
                   asteriscoFila2

                   mov            dl,11
                   mov            dh, 45
                   asteriscoFila2

    ; ;parte arriba

                   mov            dl,1
                   mov            dh, 11
                   asteriscoFila3
                    

                   mov            dl,1
                   mov            dh, 23
                   asteriscoFila3

                   mov            dl,1
                   mov            dh, 35
                   asteriscoFila3

                   mov            dl,5
                   mov            dh, 2
                   asteriscoFila4

                   mov            dl,9
                   mov            dh, 2
                   asteriscoFila4

                   mov            dl,13
                   mov            dh, 2
                   asteriscoFila4
                   endM
cubiculo Macro color                                              ;Crea el tablero
                   local          salirC, ciclo, linea1
                   mov            dx, N
                   mov            ah, color
                   mov            si, 484
    ciclo:         
                   cmp            dx, 0
                   je             salirC
                   add            si, 4
                   mov            cx, 7
    linea1:        
                   mov            word ptr es:[si], ax
                   add            si,2
                   mov            word ptr es:[si], ax
                   add            si,2
                   mov            word ptr es:[si], ax
                   add            si,2
                    
                   add            si,6

                   loop           linea1
                   dec            dx
                   add            si, 232
                   jmp            ciclo
    salirC:        
                   endM
   
Tablero Macro
    N              =              25
                   franjaH        azul
   
    N              =              7
                   cubiculo       amarilla
                   EndM

MENU Macro

    N              =              33
                   FRANJAV        negra

                   EndM

funcionPrueba proc near
                   mov            ah, 09h
                   lea            dx, agregarjugador4
                   int            21h
                   ret

funcionPrueba endp


Tecla Macro
                   xor            ah,ah
                   int            16h
                   EndM


tomaDatos proc near
                   mov            ah, 09h
                   lea            dx, msgFilas
                   int            21h
                    
                   mov            ah,01h
                   int            21h
                   mov            filasE,al

                   mov            ah, 09h
                   lea            dx, msgColumnas
                   int            21h
                    
                   mov            ah,01h
                   int            21h
                   mov            coluE,al

                   mov            ah, 09h
                   lea            dx, msgpocision
                   int            21h
                    
                   mov            ah,01h
                   int            21h
                   mov            posE,al

                   ret
tomaDatos endp


PrnRot Proc
    ; Recibe en el DS:[si] un puntero al rÃ³tulo.  Supone que es un asciiz
    ; Recibe en el DX la coordenada donde se debe desplegar (DL=Fila y DH=Columna)
    ; Recibe en el BX el color (BL=Foreground y BH=Background)

                   push           ax
                   push           bx
                   push           cx
                   push           dx
                   push           di
                   push           si
                   push           es

                   mov            ax, 0B800h                      ; pone el ES a apuntar al segmento de video
                   mov            es, ax

                   mov            Al, Dl                          ; calcula el desplazamiento en la memoria de video necesario para llegar
                   mov            cl, 80                          ; a la fila y columna solicitada.
                   mul            cl                              ; es similar a accesar una matriz.
                   mov            cl, dh
                   xor            ch, ch
                   add            ax, cx
                   shl            ax, 1
                   mov            di, ax
         
                   mov            ah, bl                          ; montamos el byte de color.
                   and            ah,0Fh
                   mov            cl, 4
                   shl            bh, cl
                   or             ah, bh

    cicPrnRot:     
                   cmp            byte ptr [si],0
                   je             salirprnRot

                   mov            al, byte ptr [si]               ; copiamos el ascii del rotulo
                   mov            word ptr Es:[di], ax            ; ponemos en pantalla el caracter con todo y color.
                   inc            di                              ; en la pantalla avanzamos de dos en dos
                   inc            di
                   inc            si                              ; en el rotulo de uno en uno
                   jmp            cicPrnRot

    salirprnRot:   
                   pop            es
                   pop            si
                   pop            di
                   pop            dx
                   pop            cx
                   pop            bx
                   pop            ax
                   ret

PrnRot EndP

printTablero proc

                   push           ax
                   push           bx
                   push           cx
                   push           dx
                   push           di
                   push           si
                   push           es
    ;Se imprimen todos los borden normles
                   mov            byte ptr Fil, 0
                   mov            byte ptr Col, 0
                   marcoArriba
                    
                   mov            byte ptr Fil, 2
                   mov            byte ptr Col, 4
                   bordeP
                   mov            byte ptr Fil, 4
                   bordeP
                   mov            byte ptr Fil, 6
                   bordeP
                   mov            byte ptr Fil, 8
                   bordeP
                   mov            byte ptr Fil, 10
                   bordeP
                   mov            byte ptr Fil, 12
                   bordeP
                   mov            byte ptr Fil, 14
                   bordeP
                   mov            byte ptr Fil, 16
                   bordeP


                   mov            byte ptr Fil, 19
                   mov            byte ptr Col, 0
                   marcoArriba

                   marcoDesign2
                  
                   pop            es
                   pop            si
                   pop            di
                   pop            dx
                   pop            cx
                   pop            bx
                   pop            ax
                   ret
printTablero endp


PrintMenu proc

                   push           ax
                   push           bx
                   push           cx
                   push           dx
                   push           di
                   push           si
                   push           es

		   mov byte ptr ColB, 0
		   mov byte ptr ColF, 22h

                   mov            byte ptr Fil, 1
                   mov            byte ptr Col, 59
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, titulo
                   call           prnRot

                   mov            byte ptr Fil, 4
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, ayuda
                   call           prnRot

                   mov            byte ptr Fil, 6
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, acercade
                   call           prnRot

                   mov            byte ptr Fil, 8
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, nuevapartida
                   call           prnRot

                   mov            byte ptr Fil, 10
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador1
                   call           prnRot

                   mov            byte ptr Fil, 12
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador2
                   call           prnRot

                   mov            byte ptr Fil, 14
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador3
                   call           prnRot

                   mov            byte ptr Fil, 16
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador4
                   call           prnRot

                   mov            byte ptr Fil, 18
                   mov            byte ptr Col, 49
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, jugar
                   call           prnRot

                   pop            es
                   pop            si
                   pop            di
                   pop            dx
                   pop            cx
                   pop            bx
                   pop            ax
                   ret

PrintMenu endP




Bicho proc
                   push           ax
                   push           bx
                   push           cx
                   push           dx
                   push           di
                   push           si
                   push           es

	MOV AX,0B800H
        MOV ES,AX
;		mov byte ptr FILBi, 9
;		mov byte ptr COLBi, 23
;		mov byte ptr ASTERIX, 'v'
	CALL MOVIMIENTO1

		   XOR AH,AH
		   INT 16H
		   CMP AL,'V'
		   je vertical_1
		   CMP AL,'H'
		   je horizontal_1
		   jmp siguex
siguex:
		   mov            byte ptr Fil, 23
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, errorAlfombraPos
                   call           prnRot
		   jmp finalBicho
vertical_1:
		   mov byte ptr direccionAlfombra, al
		   jmp finalBicho
horizontal_1:
		   mov byte ptr direccionAlfombra, al
		   jmp finalBicho

        ;MOV AX, 4C00h
        ;INT 21h

MOVIMIENTO1 PROC NEAR
; Este procedimiento pone el asterisco, hace una pasua y lo mueve un campo
  
DESPLEGAR1:

		MOV AL,160           ; Calculamos BX = FIL*160+Col*2 
	        MUL FILBi
	        XOR BH, BH
	        MOV BL, COLBi
	        SHL BX,1
	        ADD BX,AX



        MOV DX,WORD PTR ES:[BX]     ; Salvamos lo que hay en la pantalla
        MOV AX,WORD PTR ASTERIX     ; Movemos al AX el asterisco


        MOV WORD PTR ES:[BX],AX     ; Ponemos la arroba en pantalla


        MOV CX, PAUSA1       ; Hacemos una pausa de 100 x 1000 nops
P1_1:     PUSH CX
        MOV CX, PAUSA2
P2_1:     NOP
        LOOP P2_1
        POP CX
        LOOP P1_1


        MOV WORD PTR ES:[BX],DX    ; Borramos la arroba
        jmp revisartecla1



revisartecla1:
		;INTERRUPCION DE TECLADO
		MOV AH,01H
		INT 16H
		JZ  auxilio1         
            	JMP HAYTECLA1
      auxilio1:  JMP DESPLEGAR1 ; Algor  

;----------------------------MUEVE EL ASTERISCO---------------------------
ALGOR1:

           CMP DIRBi, 0      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE1_1
           JMP CERO_1
PREGUNTE1_1: CMP DIRBi, 1      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE2_1
           JMP UNO_1
PREGUNTE2_1: CMP DIRBi, 2      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE3_1
           JMP DOS_1
PREGUNTE3_1: CMP DIRBi, 3      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE8_1;4
           JMP TRES_1
PREGUNTE8_1: CMP DIRBi, 8      ; Con saltos de conejo pues ya da fuera de rango
           JNE PREGUNTE9_1
           JMP OCHO_1

PREGUNTE9_1:  Jmp Repetir1


CERO_1:  CMP FILBi,3
       JE CD0_1   
       DEC FILBi
       DEC FILBi
CD0_1:   MOV DIRBi, 0
       JMP REPETIR1

UNO_1:   CMP COLBi,5
       JE CD1_1   
       DEC COLBi
       DEC COLBi
       DEC COLBi
       DEC COLBi
       DEC COLBi
       DEC COLBi
CD1_1:   MOV DIRBi, 1
       JMP REPETIR1

DOS_1:   CMP COLBi,41
       JE CD2_1   
       INC COLBi
       INC COLBi
       INC COLBi
       INC COLBi
       INC COLBi
       INC COLBi
CD2_1:   MOV DIRBi, 2
       JMP REPETIR1

TRES_1:  CMP FILBi,15
       JE CD3_1  
       INC FILBi
       INC FILBi
CD3_1:   MOV DIRBi, 3
       JMP REPETIR1

OCHO_1:
	jmp salir1 

	;mov ah, 09h
	;lea dx, FIL
	;int 21h
	;mov ah, 09h
	;lea dx, COL
	;int 21h
	;mov ah, 09h
	;lea dx, HOLAXD
	;int 21h
	;cmp FIL, 23
	;je siguee1
	;jmp REPETIR
;siguee1:
;	cmp COL, 1
;	je siguee2
;	jmp REPETIR
;siguee2:
;                   mov            byte ptr fil1, 24
;                   mov            byte ptr col1, 1
;                   mov            dl, fil1
;                   mov            dh, col1
;                   mov            bh, ColB
;                   mov            bl, ColF
;                   lea            si, HOLAXD
;                   call           prnRot
;
;	jmp REPETIR


;------------------------------------------------------------------------		
;PROCESA LA TECLA DE FUNCION EXTENDIDA
HAYTECLA1:	        XOR AH,AH
			INT 16H
			;CMP AL,'y'	;Se sale con una x minuscula
			;JNZ siguexd1
			;jmp SALIR1
;siguexd1:			
			;CMP AL,0
			;JZ REVISE_DIR
			;JMP ALGOR
			
REVISE_DIR1:	
		S4_1:	CMP AH,72	;SI ES flecha arriba
			JNZ S5_1
                        MOV DIRBi,0  
			mov byte ptr ASTERIX, '^'
			JMP salircambiodir1
		S5_1:	CMP AH,75	;SI ES flecha izquierda
			JNZ S6_1
                        MOV DIRBi,1  
			mov byte ptr ASTERIX, '<'
			JMP salircambiodir1
		S6_1:	CMP AH,77	;SI ES flecha derecha
			JNZ S7_1
                        MOV DIRBi,2  
			mov byte ptr ASTERIX, '>'
			JMP salircambiodir1
		S7_1:	CMP AH,80	;SI ES flecha abajo
			JNZ S8_1
                        MOV DIRBi,3  
			mov byte ptr ASTERIX, 'v'
			JMP salircambiodir1
                S8_1:	CMP al, 'i' ;AH,90	;SI ES ENTER
			JNZ S9_1
                        MOV DIRBi,8  
			JMP salircambiodir1
		S9_1:
      
     
 salircambiodir1:        jmp algor1    ; jmp desplegar
                

		
			
REPETIR1: JMP DESPLEGAR1

SALIR1:  ;RET
                   mov            byte ptr Fil, 22
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, msgpocision
                   call           prnRot

	RET

MOVIMIENTO1 ENDP
		   
finalBicho:
;		   mov            byte ptr Fil, 23
;                   mov            byte ptr Col, 1
;                   mov            dl, Fil
;                   mov            dh, Col
;		   mov		  byte ptr ColB, 01000100b
;		   mov		  byte ptr ColF, 07Fh
;                   mov            bh, ColB
;                   mov            bl, ColF
;                   lea            si, RotXD
;                   call           prnRot		   
                   pop            es
                   pop            si
                   pop            di
                   pop            dx
                   pop            cx
                   pop            bx
                   pop            ax
                   ret
Bicho endP







                           
    main:          push           ds
                   pop            es
                   mov            ax, ds
                   mov            es, ax
                   mov            ax, datos
                   mov            ds, ax
                   mov            ax, pila
                   mov            ss, ax

                   

    programa:     

		   mov            ax, 0B800h
                   mov            es, ax
                   xor            si, si
                   mov            al, 219

                   Tablero
                   call           printTablero
 
                   mov            ax, 0B800h
                   mov            es, ax
                   xor            si, si
                   mov            al, 219

                   MENU
                   call           PrintMenu


    

    revisartecla:  
    ;INTERRUPCION DE TECLADO
                   MOV            AH,01H
                   INT            16H
                   JZ             auxilio
                   JMP            HAYTECLA
    auxilio:       jmp            revisartecla                    ;HAYTECLA ;salir;JMP DESPLEGAR ; Algor

    ALGOR:         

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 0
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo4
                   call           prnRot
                   mov            byte ptr Fil, 22
                   mov            byte ptr Col, 0
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo4
                   call           prnRot
                   mov            byte ptr Fil, 23
                   mov            byte ptr Col, 0
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo4
                   call           prnRot
                   mov            byte ptr Fil, 24
                   mov            byte ptr Col, 0
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo4
                   call           prnRot


                   CMP            DIR, 0                          ; Con saltos de conejo pues ya da fuera de rango
                   JNE            PREGUNTE1
                   JMP            CERO
    PREGUNTE1:     CMP            DIR, 1                          ; Con saltos de conejo pues ya da fuera de rango
                   JNE            PREGUNTE2
                   JMP            UNO
    PREGUNTE2:     CMP            DIR, 2                          ; Con saltos de conejo pues ya da fuera de rango
                   JNE            PREGUNTE3
                   JMP            DOS
    PREGUNTE3:     CMP            DIR, 3                          ; Con saltos de conejo pues ya da fuera de rango
                   JNE            PREGUNTE4
                   JMP            TRES
    PREGUNTE4:     CMP            DIR, 4                          ; Con saltos de conejo pues ya da fuera de rango
                   JNE            PREGUNTE5
                   JMP            CUATRO
    PREGUNTE5:     CMP            DIR, 5
                   JNE            PREGUNTE6
                   JMP            CINCO
    PREGUNTE6:     CMP            DIR, 6
                   JNE            PREGUNTE7
                   JMP            SEIS
    PREGUNTE7:     CMP            DIR, 7
                   JNE            PREGUNTE8
                   JMP            SIETE
    PREGUNTE8:     Jmp            salir


    CERO:          
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo5
;                   int            21h
;                   mov            ah, 09h
;                   lea            dx, Rotulo6
;                   int            21h
;                   mov            ah, 09h
;                   lea            dx, Rotulo7
;                   int            21h
;                   mov            ah, 09h
;                   lea            dx, Rotulo4
;                   int            21h


                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo5
                   call           prnRot
                   mov            byte ptr Fil, 22
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo6
                   call           prnRot
                   mov            byte ptr Fil, 23
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo7
                   call           prnRot

                   jmp            salir

    UNO:           
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo1
;                   int            21h
;                   mov            ah, 09h
;                   lea            dx, Rotulo2
;                   int            21h
;                   mov            ah, 09h
;                   lea            dx, Rotulo3
;                   int            21h
;                   mov            ah, 09h
;                   lea            dx, Rotulo4
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo1
                   call           prnRot
                   mov            byte ptr Fil, 22
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo2
                   call           prnRot
                   mov            byte ptr Fil, 23
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo3
                   call           prnRot

                   jmp            salir

    DOS:           
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo8
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo8
                   call           prnRot

                   jmp            salir

    TRES:          
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo9
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo9
                   call           prnRot

                   jmp            salir

    CUATRO:        
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo10
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo10
                   call           prnRot

                   jmp            salir

    CINCO:         
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo11
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo11
                   call           prnRot

                   jmp            salir

    SEIS:          
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo12
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo12
                   call           prnRot

                   jmp            salir

    SIETE:         
;                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
;                   int            10h
;                   mov            ah, 09h
;                   lea            dx, Rotulo13
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo13
                   call           prnRot

		   call           Bicho

                   jmp            salir






    ;PROCESA LA TECLA DE FUNCION EXTENDIDA
    HAYTECLA:      
;                   mov            ah, 09h
;                   lea            dx, RotXD
;                   int            21h
                   XOR            AH,AH
                   INT            16H
                   CMP            AL,'x'                          ;Se sale con una x minuscula
                   JZ             fin1
		   jmp REVISE_DIR
    fin1: jmp fin
			
    ;CMP AL,0
    ;JZ REVISE_DIR
    ;JMP ALGOR
			
    REVISE_DIR:                                                   ;CMP AH,47H	;SI ES HOME
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
    S4:                                                           ;CMP AH,1C	;SI ES A
                   cmp		  al, 'A'
                   JNZ            S5
                   MOV            DIR,0
                   JMP            salircambiodir
    S5:                                                           ;CMP AH,32	;SI ES B
                   cmp            al, 'B'
                   JNZ            S6
                   MOV            DIR,1
                   JMP            salircambiodir
    S6:                                                           ;CMP AH,21	;SI ES C
                   cmp            al, 'C'
                   JNZ            S7
                   MOV            DIR,2
                   JMP            salircambiodir
    S7:                                                           ;CMP AH,23	;SI ES D
                   cmp            al, 'D'
                   JNZ            S8
                   MOV            DIR,3
                   JMP            salircambiodir
    S8:                                                           ;CMP AH,24	;SI ES E
                   cmp            al, 'E'
                   JNZ            S9
                   MOV            DIR,4
                   JMP            salircambiodir
    S9:                                                           ;CMP AH,2B	;SI ES F
                   cmp            al, 'F'
                   JNZ            S10
                   MOV            DIR,5
                   JMP            salircambiodir
    S10:                                                          ;CMP AH,34	;SI ES G
                   cmp            al, 'G'
                   JNZ            S11
                   MOV            DIR,6
                   JMP            salircambiodir
    S11:                                                          ;CMP AH,33	;SI ES H
                   cmp            al, 'H'
                   JNZ            S12
                   MOV            DIR,7
                   JMP            salircambiodir
    S12:           
      
     
    salircambiodir:jmp            algor                           ; jmp desplegar


    salir:         
;                   mov            ah, 09h
;                   lea            dx, Rotulo14
;                   int            21h

                   mov            byte ptr Fil, 24
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo14
                   call           prnRot

                   Tecla
                   jmp            programa
    fin:           
;                   mov            ah, 09h
;                   lea            dx, Rotulo15
;                   int            21h

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 1
                   mov            dl, Fil
                   mov            dh, Col
		   mov		  byte ptr ColB, 01000100b
		   mov		  byte ptr ColF, 07Fh
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, Rotulo15
                   call           prnRot

                   Tecla
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h


                   mov            ax, 4C00h                       ; protocolo de finalización del programa.
                   int            21h
     

codigo ends

end main