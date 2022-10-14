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
    ColF            db  33h
    dir             db  8
   
    filasE          db  0
    coluE           db  0
    posE            db  0




    ;----------------------------Rotulos----------------------------------------
    Rotulo1         db  "Este programa simula una replica del juego de Marrakech",10,13,'$'
    Rotulo2         db  "El programa despliega una interfaz grafica en modo texto",10,13,'$'
    Rotulo3         db  "Tambien utiliza el teclado para ejecutarse y recibir instrucciones",10,13,'$'
    Rotulo4         db  " ",10,13,'$'
    Rotulo5         db  "Digite alguna de las letras de las opciones para ejecutar una accion",10,13,'$'
    Rotulo6         db  "Para salir del programa digite una x minuscula",10,13,'$'
    Rotulo7         db  "posteriormente digite cualquier tecla para finalizar por completo",10,13,'$'
    Rotulo8         db  "Se creo una nueva partida",10,13,'$'
    Rotulo9         db  "Se agrego al jugador 1",10,13,'$'
    Rotulo10        db  "Se agrego al jugador 2",10,13,'$'
    Rotulo11        db  "Se agrego al jugador 3",10,13,'$'
    Rotulo12        db  "Se agrego al jugador 4",10,13,'$'
    Rotulo13        db  "Haga su jugada",10,13,'$'
    Rotulo14        db  "Digite cualquier tecla si quiere regresar al menu",10,13,'$'
    Rotulo15        db  "Digite cualquier tecla para salir del programa",10,13,'$'
    RotXD           db  "HOLA XD",10,13,'$'
    
    titulo          db  "INICIO",0
    ayuda           db  "AYUDA",0
    acercade        db  "DESPLEGAR ACERCA DE",0
    nuevapartida    db  "NUEVA PARTIDA",0
    agregarjugador1 db  "AGREGAR JUGADOR 1",0
    agregarjugador2 db  "AGREGAR JUGADOR 2",0
    agregarjugador3 db  "AGREGAR JUGADOR 3",0
    agregarjugador4 db  "AGREGAR JUGADOR 4",0
    jugar           db  "JUGAR PARTIDA ACTUAL",0


    msgFilas        db  "Ingrese la pocicion de filas: ",10,13,"$"
    msgColumnas     db  "Ingrese la pocicion de columnas: ",10,13,"$"
    msgpocision     db  "Ingrese V o H para su pocicion: ",10,13,"$"


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


                   mov            byte ptr Fil, 3
                   mov            byte ptr Col, 59
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, titulo
                   call           prnRot

                   mov            byte ptr Fil, 7
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, ayuda
                   call           prnRot

                   mov            byte ptr Fil, 9
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, acercade
                   call           prnRot

                   mov            byte ptr Fil, 11
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, nuevapartida
                   call           prnRot

                   mov            byte ptr Fil, 13
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador1
                   call           prnRot

                   mov            byte ptr Fil, 15
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador2
                   call           prnRot

                   mov            byte ptr Fil, 17
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador3
                   call           prnRot

                   mov            byte ptr Fil, 19
                   mov            byte ptr Col, 48
                   mov            dl, Fil
                   mov            dh, Col
                   mov            bh, ColB
                   mov            bl, ColF
                   lea            si, agregarjugador4
                   call           prnRot

                   mov            byte ptr Fil, 21
                   mov            byte ptr Col, 48
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

                           
    main:          push           ds
                   pop            es
                   mov            ax, ds
                   mov            es, ax
                   mov            ax, datos
                   mov            ds, ax
                   mov            ax, pila
                   mov            ss, ax

                   mov            ax, 0B800h
                   mov            es, ax
                   xor            si, si
                   mov            al, 219

                   Tablero
                   call           printTablero

    programa:      
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
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo5
                   int            21h
                   mov            ah, 09h
                   lea            dx, Rotulo6
                   int            21h
                   mov            ah, 09h
                   lea            dx, Rotulo7
                   int            21h
                   mov            ah, 09h
                   lea            dx, Rotulo4
                   int            21h
                   jmp            salir

    UNO:           
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo1
                   int            21h
                   mov            ah, 09h
                   lea            dx, Rotulo2
                   int            21h
                   mov            ah, 09h
                   lea            dx, Rotulo3
                   int            21h
                   mov            ah, 09h
                   lea            dx, Rotulo4
                   int            21h
                   jmp            salir

    DOS:           
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo8
                   int            21h
                   jmp            salir

    TRES:          
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo9
                   int            21h
                   jmp            salir

    CUATRO:        
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo10
                   int            21h
                   jmp            salir

    CINCO:         
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo11
                   int            21h
                   jmp            salir

    SEIS:          
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo12
                   int            21h
                   jmp            salir

    SIETE:         
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h
                   mov            ah, 09h
                   lea            dx, Rotulo13
                   int            21h
                   jmp            salir






    ;PROCESA LA TECLA DE FUNCION EXTENDIDA
    HAYTECLA:      
                   mov            ah, 09h
                   lea            dx, RotXD
                   int            21h
                   XOR            AH,AH
                   INT            16H
                   CMP            AL,'x'                          ;Se sale con una x minuscula
                   JZ             fin
			
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
                   cmp            al, 'A'
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
                   mov            ah, 09h
                   lea            dx, Rotulo14
                   int            21h

                   Tecla
                   jmp            programa
    fin:           
                   mov            ah, 09h
                   lea            dx, Rotulo15
                   int            21h

                   Tecla
                   mov            ax, 03h                         ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                   int            10h


                   mov            ax, 4C00h                       ; protocolo de finalización del programa.
                   int            21h
     

codigo ends

end main                                
