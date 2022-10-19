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
    azul                 EQU 00010001b
    morado               EQU 00011001b
    roja                 EQU 01000100b
    blanca               EQU 07Fh
    negra                EQU 0
    amarilla             EQU 0Eh
    verde                EQU 22h
    cyan                 EQU 33h
    blue                 EQU 1h

    cafe                 EQU 6h
    lgris                EQU 7h
    lmagenta             EQU Dh   
  
    ;----------------------------Datos----------------------------------------
    Fil                  db  0
    Col                  db  0

    ColB                 db  0
    ColF                 db  33h
    dir                  db  8
   
    filasE               db  0
    coluE                db  0
    posE                 db  0

    NPC                  dw  0
    DNPC                 db  0
    DNPCA                db  0
    dado                 db  0
    ResDado              db  0
    varX                 db  0
    varY                 db  0

    fila                 db  0
    columna              db  0
    columnaAux           db  0
    direccion            db  ?

    jugadores            db  0
    colorP               db  ?
    colorLeido           db  0

    pocisionP            db  ?
    pocisionLeida        db  ?

    colorVerificacion    db  0

    brownCoins           db  0
    redCoins             db  0
    blueCoins            db  0
    yellowCoins          db  0

    redCarpets           db  0
    blueCarpets          db  0
    greenCarpets         db  0
    yellowCarpets        db  0

    FILBi                DB  3
    COLBi                DB  3
    DIRBi                DB  9
    DIRBi2               DB  9
    ASTERIX              DB  'v',0AH                                                                                                                                                                                                                ; Fondo negro y arroba verde CLARO
    PAUSA1               dw  1000
    PAUSA2               dw  100

    direccionAlfombra    db  ?


    ;----------------------------Archivos-Tableros-----------------------------
    matrizOriginal       db  ".......", 10, ".......", 10, ".......", 10,".......", 10,".......", 10,".......", 10,"......."
    Semilla              dw  ?
    
    matrizActualC        db  128 dup ( 0 )
    matrizActualP        db  128 dup ( 0 )

    matrizTemporalC      db  128 dup ( 0 )
    matrizTemporalP      db  128 dup ( 0 )
    BuffyC               db  256 dup(0)
    BuffyP               db  256 dup(0)

    nombArchivoC         db  "COLORS.TXT",0
    nombArchivoP         db  "POSITIONS.TXT",0
    handleS              dw  ?
    handleP              dw  ?


    ;----------------------------Rotulos----------------------------------------
    Rotulo1              db  "Este programa simula una replica del juego de Marrakech",0                                                                                                                                                            ;10,13,'$'
    Rotulo2              db  "El programa despliega una interfaz grafica en modo texto",0                                                                                                                                                           ;10,13,'$'
    Rotulo3              db  "Tambien utiliza el teclado para ejecutarse y recibir instrucciones",0                                                                                                                                                 ;10,13,'$'
    Rotulo4              db  "                                                                                ",0                                                                                                                                   ;10,13,'$'
    Rotulo5              db  "Digite alguna de las letras de las opciones para ejecutar una accion",0                                                                                                                                               ;10,13,'$'
    Rotulo6              db  "Para salir del programa digite una x minuscula",0                                                                                                                                                                     ;10,13,'$'
    Rotulo7              db  "posteriormente digite cualquier tecla para finalizar por completo",0                                                                                                                                                  ;10,13,'$'
    Rotulo8              db  "Se creo una nueva partida",0                                                                                                                                                                                          ;10,13,'$'
    Rotulo9              db  "Se agrego al jugador 1",0                                                                                                                                                                                             ;10,13,'$'
    Rotulo10             db  "Se agrego al jugador 2",0                                                                                                                                                                                             ;10,13,'$'
    Rotulo11             db  "Se agrego al jugador 3",0                                                                                                                                                                                             ;10,13,'$'
    Rotulo12             db  "Se agrego al jugador 4",0                                                                                                                                                                                             ;10,13,'$'
    Rotulo13             db  "Haga su jugada, digite i para lanzar el dado",0                                                                                                                                             ;10,13,'$'
    Rotulo14             db  "Digite cualquier tecla si quiere regresar al menu: ",0                                                                                                                                                                ;10,13,'$'
    Rotulo15             db  "Digite cualquier tecla para salir del programa: ",0                                                                                                                                                                   ;10,13,'$'
    RotXD                db  "HOLA XD",0
    errorAlfombraPos     db  "Ingrese unicamente V o H",0   
    errorFilasTablero    db  "Las filas del tablero son unicamente letras de la A a la G",0                                                                                                                                                                                      ;10,13,'$'
    errorColumnasTablero db  "Las columnas del tablero son unicamente letras de la A a la G",0
    ResultDado           db  "Resultado del dado: 0",0

    RotJ1                db  "Jugador 1",0
    RotD1                db  "000",0
    RotA1                db  "00",0
    RotJ2                db  "Jugador 2",0
    RotD2                db  "000",0
    RotA2                db  "00",0
    RotJ3                db  "Jugador 3",0
    RotD3                db  "000",0
    RotA3                db  "00",0
    RotJ4                db  "Jugador 4",0
    RotD4                db  "000",0
    RotA4                db  "00",0
    RotDinero            db  "$ ",0
    RotAlfombra          db  "#: ",0
    
    titulo               db  "INICIO",0
    ayuda                db  "A -> AYUDA",0
    acercade             db  "B -> DESPLEGAR ACERCA DE",0
    nuevapartida         db  "C -> NUEVA PARTIDA",0
    agregarjugador1      db  "D -> AGREGAR JUGADOR 1",0
    agregarjugador2      db  "E -> AGREGAR JUGADOR 2",0
    agregarjugador3      db  "F -> AGREGAR JUGADOR 3",0
    agregarjugador4      db  "G -> AGREGAR JUGADOR 4",0
    jugar                db  "H -> JUGAR PARTIDA ACTUAL",0

    enterMsg             db  " ",10,13,'$'
    msgNoSobrescribir    db  "No se va a sobrescribir el tablero",10,13,'$'
    inputArchivoC        db  "Ya existe tablero de colores, si quiere reiniciarlo opima Y, sino cualquier tecla",10,13,'$'
    inputArchivoP        db  "Ya existe tablero de pocisiones, si quiere reiniciarlo opima Y, sino cualquier tecla",10,13,'$'
    msgTablerosC         db  "Se crearon los tableros nesesarios",10,13,'$'
    msgCaracterExistente db  "No se puede colocar el caracter porque ya existe uno en esa pocicion",10,13,'$'
    colorInvalido        db  "No se puede colocar el color porque esta en un formato erroneo",10,13,'$'
    posicionInvalida     db  "No se puede colocar la pocision por formato erroneo",10,13,'$'
    msgETablero          db  "Hubo un error al escribir el tablero dentro del archivo",10,13,'$'
    msgUpdateFail        db  "La actualizacion de colores no fue exitosa",10,13,'$'
    msgEPosicion         db  "No se puede colocar la alfombra sobre el personaje",10,13,'$'
    msgDireccionE        db  "La direccion ingresada no existe",10,13,'$'


    msgFilas             db  "Ingrese la pocicion de filas:      ",0                                                                                                                                                                                     ;10,13,"$"
    msgColumnas          db  "Ingrese la pocicion de columnas:   ",0                                                                                                                                                                                  ;10,13,"$"
    msgpocision          db  "Ingrese V o H para su pocicion:    ",0 

    letraFila            db  ?
    letraColumna         db  ?                                                                                                                                                                                  ;10,13,"$"


    marco                db  "=======================================",0
    marco2               db  ""
    marco3               db  "-------------oooOO-($$$)-OOooo-----------------",0

    marco6               db  0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0C9h,0CDh,0CAh,0CDh,0CDh,0BBh,0

    marco7               db  0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0C9h,0CDh,0CDh,0CDh,0CDh,0BBh,0

    marco8               db  0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0C8h,0CDh,0CDh,0CDh,0CDh,0BCh,0

    marco9               db  0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0C8h,0CDh,0CBh,0CDh,0CDh,0BCh,0

    aT                   db  0C9h,0                                                                                                                                                                                                                 ;╔
    ar                   db  0CCh,0                                                                                                                                                                                                                 ;╠
    lhn                  db  0B9h,0                                                                                                                                                                                                                 ;╣

    aV                   db  0BAh,0                                                                                                                                                                                                                 ;║
    dIz                  db  0C8h,0                                                                                                                                                                                                                 ;╚
    ad                   db  0BBh,0                                                                                                                                                                                                                 ;╗

    adh                  db  0CAh,0                                                                                                                                                                                                                 ;╩
    ddh                  db  0BCh,0                                                                                                                                                                                                                 ;╝
    ld                   db  0CDh,0                                                                                                                                                                                                                 ;═
    ls                   db  0CBh,0                                                                                                                                                                                                                ;╦

    as                   db  "*",0

    cuadroColor          db 219,0
    flechaAbajo          db 25,0
    flechaArriba         db 24,0
    flechaDerecha        db 26,0
    flechaIzquierda      db 27,0
    rayitaM              db '-',0
    rayitaB              db '_',0
    gato                 db '#',0
    gorro                db 176,0
    ojo                  db '0',0
    raro                 db 232,0


    redDesign            db  0CDh,0CBh,0CDh,0CBh,0CDh,0CBh,0

datos endS

pila segment stack 'stack'
         dw 256 dup(?)
pila endS

codigo segment

                             assume         cs:codigo, ds:datos, ss:pila

    ;--------------------------------Macros---------------------------------------------------------------------------------------------------------------
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------
FRANJAV Macro color
                             local          franja1, salir, ciclo

                             mov            ah, color
                             mov            dx, N
                             mov            si, 94
    ciclo:                   cmp            dx, 0
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

franjaH Macro color                                                             ;Pone colores
                             local          franja1

                             mov            cx, 80*N
                             mov            ah, color
    franja1:                 
                             mov            word ptr es:[si], ax
                             inc            si
                             inc            si
                             loop           franja1
                             endM

bordeP Macro color                                                              ;Macro con borde principal
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, blue
                             mov            bl, verde
                             lea            si, marco7                          ; Marco 7 es [marco7 db  0DCh]
                             call           PrnRot
                             endM

bordeE Macro color                                                              ;Macro con borde principal
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, blue
                             mov            bl, verde
                             lea            si, marco8
                             call           PrnRot
                             endM

centro Macro
                             local          ciclo, salirC                       ;Macro con borde principal
                             mov            cx, 5
                             mov            bh, blue
                             mov            bl, verde
                             mov            dl, Fil
                             mov            dh, Col

                             lea            si,lhn
                             call           PrnRot
                             inc            dh
                             inc            dh
                             inc            dh
                             inc            dh
                             inc            dh
                             lea            si, aV
                             call           PrnRot
                             inc            dh

    ciclo:                   
                             lea            si, av
                             call           PrnRot
                             inc            dh
                             inc            dh
                             inc            dh
                             inc            dh
                             inc            dh
                             call           PrnRot
                             inc            dh
                             loop           ciclo

                             lea            si, av
                             call           PrnRot
                             inc            dh
                             inc            dh
                             inc            dh
                             inc            dh
                             inc            dh
                             lea            si, ar
                             call           PrnRot
                             endM

marcoArriba Macro color                                                         ;Macro con borde
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, azul
                             mov            bl, blanca
                             lea            si, marco3
                             call           PrnRot
                             endM

asteriscoFila Macro color                                                       ;Macro con borde
                             mov            bh, azul
                             mov            bl, blanca
                             lea            si, dIz
                             call           PrnRot

                             add            dh,1
                             lea            si, ld
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
                             lea            si, ddh
                             call           PrnRot
                             endM

asteriscoFila2 Macro color                                                      ;Macro con borde
                             mov            bh, azul
                             mov            bl, blanca
                             lea            si, ad
                             call           PrnRot

                             add            dl,1
                             lea            si, aV
                             call           PrnRot

                             add            dl,1
                             lea            si, aV
                             call           PrnRot

                             add            dl, 1
                             lea            si, ddh
                             call           PrnRot

                    
                             endM
   
asteriscoFila3 Macro color                                                      ;Macro con borde
                             mov            bh, azul
                             mov            bl, blanca
                             lea            si, aT
                             call           prnRot
                             dec            ah

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             inc            ah
                             lea            si, ad
                             call           PrnRot

                           
                             endM

asteriscoFila4 Macro color                                                      ;Macro con borde
                             mov            bh, azul
                             mov            bl, blanca
                             lea            si, at
                             call           PrnRot

                             inc            dh
                             lea            si, ld
                             call           PrnRot

                             dec            dh
                             inc            dl
                             lea            si, aV
                             call           PrnRot

                             inc            dl
                             call           PrnRot

                             inc            dl
                             lea            si, dIz
                             call           PrnRot

                            
                             inc            dh
                             lea            si, ld
                             call           PrnRot


                             endM

marcoDesign2 Macro color                                                        ;Macro con borde
    ;Parte abajo
                             mov            dl, 22
                             mov            dh, 4
                             asteriscoFila

                             mov            dl, 22
                             mov            dh, 16
                             asteriscoFila

                             mov            dl, 22
                             mov            dh, 28
                             asteriscoFila

                             mov            dl,22
                             mov            dh, 40
                             lea            si, dIz
                             call           PrnRot

                             mov            dl,22
                             mov            dh, 41
                             lea            si, ld
                             call           PrnRot

                             mov            dl,22
                             mov            dh, 42
                             call           PrnRot

                             mov            dl,22
                             mov            dh, 43
                             call           PrnRot

                             mov            dl,22
                             mov            dh, 44
                             lea            si, ddh
                             call           PrnRot

                             mov            dl,21
                             mov            dh, 44
                             lea            si, aV
                             call           PrnRot

                             mov            dl,20
                             mov            dh, 44
                             lea            si, ad
                             call           PrnRot

    ; ;parte derecha

                             mov            dl, 2
                             mov            dh, 44
                             asteriscoFila2

                             mov            dl, 8
                             mov            dh, 44
                             asteriscoFila2

                             mov            dl,14
                             mov            dh, 44
                             asteriscoFila2

    ; ; ;parte arriba

                             mov            dl,0
                             mov            dh, 10
                             asteriscoFila3

                             mov            dl,0
                             mov            dh, 22
                             asteriscoFila3

                             mov            dl,0
                             mov            dh, 34
                             asteriscoFila3

                             mov            dl,0
                             mov            dh, 0
                             lea            si, aT
                             call           PrnRot

                             mov            dl, 0
                             mov            dh, 1
                             lea            si, ld
                             call           PrnRot

                             mov            dl, 0
                             mov            dh, 2
                             call           PrnRot

                             mov            dl, 0
                             mov            dh, 3
                             call           PrnRot

                             mov            dl, 0
                             mov            dh, 4
                             call           PrnRot

                             mov            dl, 0
                             mov            dh, 4
                             lea            si, ad
                             call           PrnRot

                             mov            dl, 1
                             mov            dh, 0
                             lea            si, aV
                             call           PrnRot

                             mov            dl, 2
                             mov            dh, 0
                             lea            si, dIz
                             call           PrnRot

                             mov            dl, 2
                             mov            dh, 1
                             lea            si, ld
                             call           PrnRot
              
    ; ;Parte izquierda

                             mov            dl,5
                             mov            dh, 0
                             asteriscoFila4

                             mov            dl,11
                             mov            dh, 0
                             asteriscoFila4

                             mov            dl,17
                             mov            dh, 0
                             asteriscoFila4
                             endM
cubiculo Macro color                                                            ;Crea el tablero
                             local          salirC, ciclo, linea1
                             mov            dx, N
                             mov            ah, color
                             mov            si, 324
    ciclo:                   
                             cmp            dx, 0
                             je             salirC
                             add            si, 2
                             mov            cx, 7
    linea1:                  
                             mov            word ptr es:[si], ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si], ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si], ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si], ax
                             inc            si
                             inc            si
                           
                             inc            si
                             inc            si
                             inc            si
                             inc            si
                             loop           linea1
                             dec            dx
                             add            si, 394                             ;(80-6*2)+80 x fila
                             jmp            ciclo
    salirC:                  
                             endM
   
Tablero Macro
    N                        =              25
                             franjaH        azul
   
    N                        =              7
                             cubiculo       amarilla
                             EndM

CREARBICHO Macro
                             local          InicioCiclo
                            
                             mov            cx,3
                             push           si
    InicioCiclo:             mov            word ptr es:[si],ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si],ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si],ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si],ax
                             add            si, 154
                            
                             loop           InicioCiclo
                             xor            si,si
                             pop            si

EndM


BICHOABAJO Macro
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           prnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, negra
                             lea            si, ojo
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, negra
                             lea            si, ojo
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si,flechaAbajo
                             call           prnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si,flechaAbajo
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si,flechaAbajo
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si,flechaAbajo
                             call           PrnRot

EndM

BICHOARRIBA Macro
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           prnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaArriba
                             call           prnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaArriba
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaArriba
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaArriba
                             call           PrnRot

EndM

BICHODERECHA Macro
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           prnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, negra
                             lea            si, ojo
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaDerecha
                             call           prnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaDerecha
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaDerecha
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaDerecha
                             call           PrnRot

EndM

BICHOIZQUIERDA Macro
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             inc            dh
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si, raro ;gorro
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cafe
                             mov            bl, negra
                             lea            si, ojo
                             call           prnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             inc            dh
                             mov            bh, cafe
                             mov            bl, cafe
                             lea            si, cuadroColor
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaIzquierda
                             call           prnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaIzquierda
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaIzquierda
                             call           PrnRot

                             inc            dh
                             mov            bh, cyan
                             mov            bl, blanca
                             lea            si, flechaIzquierda
                             call           PrnRot

EndM




CrearBandera Macro
                             local          InicioBandera
                            
                             mov            cx,N
                             push           si
    InicioBandera:           mov            word ptr es:[si],ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si],ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si],ax
                             inc            si
                             inc            si
                             mov            word ptr es:[si],ax
                             add            si, 154
                            
                             loop           InicioBandera
                             xor            si,si
                             pop            si

                             EndM

verticalRed Macro
                             mov            bh, roja
                             mov            bl, blanca
                             lea            si,as
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,as
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             lea            si,as
                             call           prnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,as
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             lea            si,as
                             call           prnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,as
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             lea            si,as
                             call           prnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,as
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             lea            si,as
                             call           prnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,as
                             call           PrnRot

                             sub            dh,3
                             inc            dl

                             lea            si,as
                             call           prnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,ld
                             call           PrnRot

                             inc            dh
                             lea            si,as
                             call           PrnRot

                             endM

AlofmbraRojaV Macro
    N                        =              5
                             CrearBandera   roja
                             EndM

BICHOMACRO Macro
	CREARBICHO
EndM


MENU Macro

    N                        =              33
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


    ;--------------------------------FUNICONES---------------------------------------------------------------------------------------------------------------
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------

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

                             mov            ax, 0B800h                          ; pone el ES a apuntar al segmento de video
                             mov            es, ax

                             mov            Al, Dl                              ; calcula el desplazamiento en la memoria de video necesario para llegar
                             mov            cl, 80                              ; a la fila y columna solicitada.
                             mul            cl                                  ; es similar a accesar una matriz.
                             mov            cl, dh
                             xor            ch, ch
                             add            ax, cx
                             shl            ax, 1
                             mov            di, ax
         
                             mov            ah, bl                              ; montamos el byte de color.
                             and            ah,0Fh
                             mov            cl, 4
                             shl            bh, cl
                             or             ah, bh

    cicPrnRot:               
                             cmp            byte ptr [si],0
                             je             salirprnRot

                             mov            al, byte ptr [si]                   ; copiamos el ascii del rotulo
                             mov            word ptr Es:[di], ax                ; ponemos en pantalla el caracter con todo y color.
                             inc            di                                  ; en la pantalla avanzamos de dos en dos
                             inc            di
                             inc            si                                  ; en el rotulo de uno en uno
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
    ;  mov            byte ptr Fil, 0
    ;  mov            byte ptr Col, 0
    ;  marcoArriba
                    
                             mov            byte ptr Fil,1
                             mov            byte ptr Col, 2
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, blue
                             mov            bl, verde
                             lea            si, marco6

                             call           PrnRot

                             mov            byte ptr Fil, 4
                             mov            byte ptr Col, 2
                             bordeP

                             mov            byte ptr Fil, 7
                             mov            byte ptr Col, 2
                             bordeP

                             mov            byte ptr Fil, 10
                             mov            byte ptr Col, 2
                             bordeP

                             mov            byte ptr Fil, 13
                             mov            byte ptr Col, 2
                             bordeP

                             mov            byte ptr Fil, 16
                             mov            byte ptr Col, 2
                             bordeP

                             mov            byte ptr Fil, 19
                             mov            byte ptr Col, 2
                             bordeP

                             mov            byte ptr Fil, 2
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 5
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 8
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 11
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 14
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 17
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 20
                             mov            byte ptr Col, 2
                             centro

                             mov            byte ptr Fil, 3
                             mov            byte ptr Col, 2
                             bordeE

                             mov            byte ptr Fil, 6
                             mov            byte ptr Col, 2
                             bordeE
                            
                             mov            byte ptr Fil, 9
                             mov            byte ptr Col, 2
                             bordeE

                             mov            byte ptr Fil, 12
                             mov            byte ptr Col, 2
                             bordeE

                             mov            byte ptr Fil, 15
                             mov            byte ptr Col, 2
                             bordeE

                             mov            byte ptr Fil, 18
                             mov            byte ptr Col, 2
                             bordeE

                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 2
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, blue
                             mov            bl, verde
                             lea            si, marco9                          ; Marco 7 es [marco7 db  0DCh]
                             call           PrnRot
                            
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

                             mov            byte ptr ColB, 0
                             mov            byte ptr ColF, 22h

                             mov            byte ptr Fil, 0
                             mov            byte ptr Col, 59
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, titulo
                             call           prnRot

                             mov            byte ptr Fil, 1
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, ayuda
                             call           prnRot

                             mov            byte ptr Fil, 2
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, acercade
                             call           prnRot

                             mov            byte ptr Fil, 3
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, nuevapartida
                             call           prnRot

                             mov            byte ptr Fil, 4
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, agregarjugador1
                             call           prnRot

                             mov            byte ptr Fil, 5
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, agregarjugador2
                             call           prnRot

                             mov            byte ptr Fil, 6
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, agregarjugador3
                             call           prnRot

                             mov            byte ptr Fil, 7
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, agregarjugador4
                             call           prnRot

                             mov            byte ptr Fil, 8
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, jugar
                             call           prnRot



    ;mov            byte ptr ColB, 0
                             mov            byte ptr ColF, 07Fh

                             mov            byte ptr Fil, 10
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotJ1
                             call           prnRot

                             mov            byte ptr Fil, 11
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotDinero
                             call           prnRot

                             mov            byte ptr Fil, 11
                             mov            byte ptr Col, 51
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotD1
                             call           prnRot

                             mov            byte ptr Fil, 11
                             mov            byte ptr Col, 57
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotAlfombra
                             call           prnRot

                             mov            byte ptr Fil, 11
                             mov            byte ptr Col, 60
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotA1
                             call           prnRot


    ;mov            byte ptr ColB, 0
    ;mov            byte ptr ColF, 07Fh

                             mov            byte ptr Fil, 13
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotJ2
                             call           prnRot

                             mov            byte ptr Fil, 14
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotDinero
                             call           prnRot

                             mov            byte ptr Fil, 14
                             mov            byte ptr Col, 51
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotD2
                             call           prnRot

                             mov            byte ptr Fil, 14
                             mov            byte ptr Col, 57
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotAlfombra
                             call           prnRot

                             mov            byte ptr Fil, 14
                             mov            byte ptr Col, 60
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotA2
                             call           prnRot


    ;mov            byte ptr ColB, 0
    ;mov            byte ptr ColF, 07Fh

                             mov            byte ptr Fil, 16
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotJ3
                             call           prnRot

                             mov            byte ptr Fil, 17
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotDinero
                             call           prnRot

                             mov            byte ptr Fil, 17
                             mov            byte ptr Col, 51
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotD3
                             call           prnRot

                             mov            byte ptr Fil, 17
                             mov            byte ptr Col, 57
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotAlfombra
                             call           prnRot

                             mov            byte ptr Fil, 17
                             mov            byte ptr Col, 60
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotA3
                             call           prnRot


    ;mov            byte ptr ColB, 0
    ;mov            byte ptr ColF, 07Fh

                             mov            byte ptr Fil, 19
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotJ4
                             call           prnRot

                             mov            byte ptr Fil, 20
                             mov            byte ptr Col, 49
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotDinero
                             call           prnRot

                             mov            byte ptr Fil, 20
                             mov            byte ptr Col, 51
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotD4
                             call           prnRot

                             mov            byte ptr Fil, 20
                             mov            byte ptr Col, 57
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotAlfombra
                             call           prnRot

                             mov            byte ptr Fil, 20
                             mov            byte ptr Col, 60
                             mov            dl, Fil
                             mov            dh, Col
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, RotA4
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

                             MOV            AX,0B800H
                             MOV            ES,AX

			     ;mov fila, 3
			     ;mov columna, 3
			     call funcionBichoAbajo
                             CALL           MOVIMIENTO1
			     ;call BorrarBichoPosAct
			     call RealizarMovimientoBicho
    SolicitaDirAlfombra:
                             XOR            AH,AH
                             INT            16H
                             CMP            AL,'V'
                             je             tomaFilas
                             CMP            AL,'H'
                             je             tomaFilas
                             jmp            siguex
    siguex:                  
                             mov            byte ptr Fil, 23
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, errorAlfombraPos
                             call           prnRot
                             jmp            SolicitaDirAlfombra

    tomaFilas:               
                             mov            byte ptr Fil, 22
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, msgFilas
                             call           prnRot

			     XOR            AH,AH
                             INT            16H
			     cmp            al, 'a'
			     je		    filavalida1
			     cmp            al, 'b'
			     je		    filavalida1
			     cmp            al, 'c'
			     je		    filavalida1
			     cmp            al, 'd'
			     je		    filavalida1
			     cmp            al, 'e'
			     je		    filavalida1
			     cmp            al, 'f'
			     je		    filavalida1
			     cmp            al, 'g'
			     je		    filavalida1

			     mov            byte ptr Fil, 23
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, errorFilasTablero
                             call           prnRot
			     jmp tomaFilas
filavalida1:
			     mov byte ptr letraFila, al
tomaColumnas:
                             mov            byte ptr Fil, 22
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, msgColumnas
                             call           prnRot

			     XOR            AH,AH
                             INT            16H
			     cmp            al, 'a'
			     je		    columnavalida1
			     cmp            al, 'b'
			     je		    columnavalida1
			     cmp            al, 'c'
			     je		    columnavalida1
			     cmp            al, 'd'
			     je		    columnavalida1
			     cmp            al, 'e'
			     je		    columnavalida1
			     cmp            al, 'f'
			     je		    columnavalida1
			     cmp            al, 'g'
			     je		    columnavalida1

			     mov            byte ptr Fil, 23
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, errorColumnasTablero
                             call           prnRot
			     jmp tomaColumnas
columnavalida1:
			     mov byte ptr letraColumna, al

asignarValoresFila:
			     cmp byte ptr letraFila, 'a'
			     je asignarFA
			     jmp sigueFi_1
asignarFA:
			     mov fila, 0
			     jmp asignarValoresColumna
sigueFi_1:
			     cmp byte ptr letraFila, 'b'
			     je asignarFB
			     jmp sigueFi_2
asignarFB:
			     mov fila, 1
			     jmp asignarValoresColumna
sigueFi_2:
			     cmp byte ptr letraFila, 'c'
			     je asignarFC
			     jmp sigueFi_3
asignarFC:
			     mov fila, 2
			     jmp asignarValoresColumna
sigueFi_3:
			     cmp byte ptr letraFila, 'd'
			     je asignarFD
			     jmp sigueFi_4
asignarFD:
			     mov fila, 3
			     jmp asignarValoresColumna
sigueFi_4:
			     cmp byte ptr letraFila, 'e'
			     je asignarFE
			     jmp sigueFi_5
asignarFE:
			     mov fila, 4
			     jmp asignarValoresColumna
sigueFi_5:
			     cmp byte ptr letraFila, 'f'
			     je asignarFF
			     jmp sigueFi_6
asignarFF:
			     mov fila, 5
			     jmp asignarValoresColumna
sigueFi_6:
			     cmp byte ptr letraFila, 'g'
			     je asignarFG
			     jmp sigueFi_7
asignarFG:
			     mov fila, 6
			     jmp asignarValoresColumna
sigueFi_7:


asignarValoresColumna:
			     cmp byte ptr letraColumna, 'a'
			     je asignarCA
			     jmp sigueCo_1
asignarCA:
			     mov columna, 0
			     jmp finaltomadatos
sigueCo_1:
			     cmp byte ptr letraColumna, 'b'
			     je asignarCB
			     jmp sigueCo_2
asignarCB:
			     mov columna, 1
			     jmp finaltomadatos
sigueCo_2:
			     cmp byte ptr letraColumna, 'c'
			     je asignarCC
			     jmp sigueCo_3
asignarCC:
			     mov columna, 2
			     jmp finaltomadatos
sigueCo_3:
			     cmp byte ptr letraColumna, 'd'
			     je asignarCD
			     jmp sigueCo_4
asignarCD:
			     mov columna, 3
			     jmp finaltomadatos
sigueCo_4:
			     cmp byte ptr letraColumna, 'e'
			     je asignarCE
			     jmp sigueCo_5
asignarCE:
			     mov columna, 4
			     jmp finaltomadatos
sigueCo_5:
			     cmp byte ptr letraColumna, 'f'
			     je asignarCF
			     jmp sigueCo_6
asignarCF:
			     mov columna, 5
			     jmp finaltomadatos
sigueCo_6:
			     cmp byte ptr letraColumna, 'g'
			     je asignarCG
			     jmp sigueCo_7
asignarCG:
			     mov columna, 6
			     jmp finaltomadatos
sigueCo_7:


			     
                             ;mov            direccion, al
                             ;call           MovimientoFilas                     ;Funcion que tome las filas [0-6]
                             ;call           MovimientoColumnas                  ;Funcion que tome las columnas [0-6]

    ;bandera con los errores posibles
    ;Si bander esta correcta procede a hacer lo de poner bandera (call funcionAlfombra)
    ;Si esta mala lo que hace es no hacer el cambio y mandarlo otra vez a la interfaz

    ;Haga una funcion que lea las monedas que hay en las variables y las actualize
    ;Haga funcion que cambie el estado de las alfombras
    ;Hacer el HASM


finaltomadatos:
                             jmp            finalBicho
                           
MOVIMIENTO1 PROC NEAR
    ; Este procedimiento pone el asterisco, hace una pasua y lo mueve un campo
  
    DESPLEGAR1:              
                             ;MOV            AL,160                              ; Calculamos BX = FIL*160+Col*2
                             ;MUL            FILBi                               ;Se coloca Hasam
                             ;XOR            BH, BH
                             ;MOV            BL, COLBi
                             ;SHL            BX,1
                             ;ADD            BX,AX

                             MOV            DX,WORD PTR ES:[BX]                 ; Salvamos lo que hay en la pantalla
                             ;MOV            AX,WORD PTR ASTERIX                 ; Movemos al AX el asterisco

                             ;MOV            WORD PTR ES:[BX],AX                 ; Ponemos la arroba en pantalla

                             MOV            CX, PAUSA1                          ; Hacemos una pausa de 100 x 1000 nops
    P1_1:                    PUSH           CX
                             MOV            CX, PAUSA2
    P2_1:                    NOP
                             LOOP           P2_1
                             POP            CX
                             LOOP           P1_1

                             MOV            WORD PTR ES:[BX],DX                 ; Borramos la arroba
                             jmp            revisartecla1



    revisartecla1:           
    ;INTERRUPCION DE TECLADO
                             MOV            AH,01H
                             INT            16H
                             JZ             auxilio1
                             JMP            HAYTECLA1
    auxilio1:                JMP            DESPLEGAR1                          ; Algor

    ;----------------------------MUEVE EL ASTERISCO---------------------------
    ALGOR1:                  
                             CMP            DIRBi, 0                            ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE1_1
                             JMP            CERO_1
    PREGUNTE1_1:             CMP            DIRBi, 1                            ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE2_1
                             JMP            UNO_1
    PREGUNTE2_1:             CMP            DIRBi, 2                            ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE3_1
                             JMP            DOS_1
    PREGUNTE3_1:             CMP            DIRBi, 3                            ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE8_1                         ;4
                             JMP            TRES_1
    PREGUNTE8_1:             CMP            DIRBi, 8                            ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE9_1
                             JMP            OCHO_1

    PREGUNTE9_1:             Jmp            Repetir1


    CERO_1:                  ;CMP            FILBi,3
                             ;JE             CD0_1
                             ;DEC            FILBi
                             ;DEC            FILBi
    ;CD0_1:                   MOV            DIRBi, 0
			     ;mov fila, 3
			     ;mov columna, 3
			     call funcionBichoArriba
                             JMP            REPETIR1

    UNO_1:                   ;CMP            COLBi,5
                             ;JE             CD1_1
                             ;DEC            COLBi
                             ;DEC            COLBi
                             ;DEC            COLBi
                             ;DEC            COLBi
                             ;DEC            COLBi
                             ;DEC            COLBi
    ;CD1_1:                   MOV            DIRBi, 1
			     ;mov fila, 3
			     ;mov columna, 3
			     call funcionBichoIzquierda
                             JMP            REPETIR1

    DOS_1:                   ;CMP            COLBi,41
                             ;JE             CD2_1
                             ;INC            COLBi
                             ;INC            COLBi
                             ;INC            COLBi
                             ;INC            COLBi
                             ;INC            COLBi
                             ;INC            COLBi
    ;CD2_1:                   MOV            DIRBi, 2
			     ;mov fila, 3
			     ;mov columna, 3
			     call funcionBichoDerecha
                             JMP            REPETIR1

    TRES_1:                  ;CMP            FILBi,15
                             ;JE             CD3_1
                             ;INC            FILBi
                             ;INC            FILBi
    ;CD3_1:                   MOV            DIRBi, 3
			     ;mov fila, 3
			     ;mov columna, 3
			     call funcionBichoAbajo
                             JMP            REPETIR1

    OCHO_1:                  
			     call movimientoBicho
                       mov            byte ptr Fil, 23
                       mov            byte ptr Col, 1
                       mov            dl, Fil
                       mov            dh, Col
                       mov            bh, ColB
                       mov            bl, ColF
                       lea            si, ResultDado
                       call           prnRot
                             jmp            salir1

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
    HAYTECLA1:               XOR            AH,AH
                             INT            16H
    ;CMP AL,'y'	;Se sale con una x minuscula
    ;JNZ siguexd1
    ;jmp SALIR1
    ;siguexd1:
    ;CMP AL,0
    ;JZ REVISE_DIR
    ;JMP ALGOR
			
    REVISE_DIR1:             
    S4_1:                    CMP            AH,72                               ;SI ES flecha arriba
                             JNZ            S5_1
                             MOV            DIRBi,0
                             mov            byte ptr ASTERIX, '^'
                             JMP            salircambiodir1
    S5_1:                    CMP            AH,75                               ;SI ES flecha izquierda
                             JNZ            S6_1
                             MOV            DIRBi,1
                             mov            byte ptr ASTERIX, '<'
                             JMP            salircambiodir1
    S6_1:                    CMP            AH,77                               ;SI ES flecha derecha
                             JNZ            S7_1
                             MOV            DIRBi,2
                             mov            byte ptr ASTERIX, '>'
                             JMP            salircambiodir1
    S7_1:                    CMP            AH,80                               ;SI ES flecha abajo
                             JNZ            S8_1
                             MOV            DIRBi,3
                             mov            byte ptr ASTERIX, 'v'
                             JMP            salircambiodir1
    S8_1:                    CMP            al, 'i'                             ;AH,90	;SI ES ENTER
                             JNZ            S9_1
			     mov	    al, byte ptr DIRBi
			     mov	    DIRBi2, al
                             MOV            DIRBi,8
                             JMP            salircambiodir1
    S9_1:                    
      
     
    salircambiodir1:         jmp            algor1                              ; jmp desplegar
                

		
			
    REPETIR1:                JMP            DESPLEGAR1

    SALIR1:                                                                     ;RET
                             mov            byte ptr Fil, 22
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, msgpocision
                             call           prnRot

                             RET

MOVIMIENTO1 ENDP

MovimientoFilas proc near

    ;mov            byte ptr Fil, 23
    ;mov            byte ptr Col, 1
                             mov            dl, 22
                             mov            dh, 1
    ;mov            byte ptr ColB, 01000100b
    ; mov            byte ptr ColF, 07Fh
    ;mov            bh, ColB
    ;mov            bl, ColF

                             mov            bh, roja
                             mov            bl, blanca
                             
                             lea            si, msgFilas
                             call           prnRot

                             mov            ah,01h
                             int            21h
                             mov            fila,ah

                             ret

MovimientoFilas endp

MovimientoColumnas proc near
                             mov            dl, 22
                             mov            dh, 1

                             mov            bh, roja
                             mov            bl, blanca
                             
                             lea            si, msgColumnas
                             call           prnRot

                             mov            ah,01h
                             int            21h
                             mov            columna,ah

                             ret

MovimientoColumnas endp
		   
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


RealizarMovimientoBicho proc
                             push           ax
                             push           bx
                             push           cx
                             push           dx
                             push           di
                             push           si
                             push           es

	cmp DIRBi2, 0
	je moverArriba_1
	cmp DIRBi2, 1
	je moverIzquierda_1
	cmp DIRBi2, 2
	je moverDerecha_1
	cmp DIRBI2, 3
	je moverAbajo_1

moverArriba_1:
	jmp moverArriba
moverIzquierda_1:
	jmp moverIzquierda
moverDerecha_1:
	jmp moverDerecha
moverAbajo_1:
	jmp moverAbajo

moverArriba:
	xor cl, cl
	mov cl, dado
	mov al, byte ptr FILBi
	mov bl, byte ptr COLBi
cicloMA1:
	cmp  cl, 0
	je salirCicloMA1
	;cmp al, 0
	;je salirCicloMA1_2
	dec al
	loop cicloMA1
salirCicloMA1:
	mov FILBi, al
	mov COLBi, bl
	call funcionBichoArriba
	jmp salirProceso
salirCicloMA1_2:
	cmp bl, 0
	je MoveCol0_X
	cmp bl, 1
	je MoveCol2_X
	cmp bl, 2
	je MoveCol1_X
	cmp bl, 3
	je MoveCol4_X
	cmp bl, 4
	je MoveCol3_X
	cmp bl, 5
	je MoveCol6_X
	jmp MoveCol5

MoveCol0_X:
	jmp MoveCol0
MoveCol1_X:
	jmp MoveCol1
MoveCol2_X:
	jmp MoveCol2
MoveCol3_X:
	jmp MoveCol3
MoveCol4_X:
	jmp MoveCol4
MoveCol6_X:
	jmp MoveCol6

MoveCol0:
	dec cl
	cmp cl, 0
	je salirCicloMA1_3
CicloMA1_2_1:
	cmp cl, 0
	je salirCicloMA1_3
	inc bl
	loop CicloMA1_2_1
salirCicloMA1_3:
	mov FILBi, al
	mov COLBi, bl
	call funcionBichoDerecha
	jmp salirProceso
MoveCol1:
	dec bl
	dec cl
	cmp cl, 0
	je salirCicloMA1_4
CicloMA1_2_2:
	cmp cl, 0
	je salirCicloMA1_4
	inc al
	loop CicloMA1_2_2
MoveCol2:
	inc bl
	dec cl
	cmp cl, 0
	je salirCicloMA1_4
CicloMA1_2_3:
	cmp cl, 0
	je salirCicloMA1_4
	inc al
	loop CicloMA1_2_3
MoveCol3:
	dec bl
	dec cl
	cmp cl, 0
	je salirCicloMA1_4
CicloMA1_2_4:
	cmp cl, 0
	je salirCicloMA1_4
	inc al
	loop CicloMA1_2_4
MoveCol4:
	inc bl
	dec cl
	cmp cl, 0
	je salirCicloMA1_4
CicloMA1_2_5:
	cmp cl, 0
	je salirCicloMA1_4
	inc al
	loop CicloMA1_2_5
MoveCol5:
	dec bl
	dec cl
	cmp cl, 0
	je salirCicloMA1_4
CicloMA1_2_6:
	cmp cl, 0
	je salirCicloMA1_4
	inc al
	loop CicloMA1_2_6
MoveCol6:
	inc bl
	dec cl
	cmp cl, 0
	je salirCicloMA1_4
CicloMA1_2_7:
	cmp cl, 0
	je salirCicloMA1_4
	inc al
	loop CicloMA1_2_7
salirCicloMA1_4:
	mov FILBi, al
	mov COLBi, bl
	call funcionBichoAbajo
	jmp salirProceso

moverIzquierda:
	xor cl, cl
	mov cl, dado
	mov al, byte ptr COLBi
	mov bl, byte ptr FILBi
cicloMI:
	cmp  cl, 0
	je salirCicloMI
	cmp al, 0
	je salirCicloMI
	dec al
	loop cicloMI
salirCicloMI:
	mov FILBi, bl
	mov COLBi, al
	call funcionBichoIzquierda
	jmp salirProceso
moverDerecha:
	xor cl, cl
	mov cl, dado
	mov al, byte ptr COLBi
	mov bl, byte ptr FILBi
cicloMD:
	cmp  cl, 0
	je salirCicloMD
	cmp al, 6
	je salirCicloMD
	inc al
	loop cicloMD
salirCicloMD:
	mov FILBi, bl
	mov COLBi, al
	call funcionBichoDerecha
	jmp salirProceso
moverAbajo:
	xor cl, cl
	mov cl, dado
	mov al, byte ptr FILBi
	mov bl, byte ptr COLBi
cicloMA2:
	cmp  cl, 0
	je salirCicloMA2
	cmp al, 6
	je salirCicloMA2
	inc al
	loop cicloMA2
salirCicloMA2:
	mov FILBi, al
	mov COLBi, bl
	call funcionBichoAbajo
	jmp salirProceso

salirProceso:
                             pop            es
                             pop            si
                             pop            di
                             pop            dx
                             pop            cx
                             pop            bx
                             pop            ax
                             ret

RealizarMovimientoBicho endP


BorrarBichoPosAct proc
BorrarBichoPosAct endP

    ;--------------------------------Validaciones---------------------------------------------------------------------------------------------------------
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------
calculateAlfombra proc near
                             xor            si,si
                             xor            ax,ax
                             mov            al,fila
                             mov            bx, 480
                             mul            bx
                             add            ax, 166
                             mov            dx,ax
                             push           dx
                             xor            ax,ax
                             xor            bx,bx

                             mov            al, columna
                             mov            bl, 12
                             mul            bx
                             pop            dx
                             add            ax,dx
                             mov            si,ax
                             ret
calculateAlfombra endp

calculateTablero proc near
                             xor            ax,ax
                             xor            bx,bx
                             xor            dx,dx
                            
                             mov            al, fila
                             mov            bx, 3
                             mul            bx
                             add            ax, 1
                             xor            ah,ah
                             mov            dl, al
                             push           dx

                             xor            ax, ax
                             xor            bx,bx
                             mov            al, columna
                             mov            bx, 6
                             mul            bx
                             add            ax,3
                             xor            ah,ah
                             pop            dx
                             mov            dh,al
                             ret
calculateTablero endp

funcionAlfombra proc near

    ;mov            fila,4
    ;mov            columna, 3
    ;mov            colorP, 'R'

                             call           calculateAlfombra
                           
  
                             mov            ah, roja
                             AlofmbraRojaV

                             call           calculateTablero
                             mov            bh, roja
                             mov            bl, blanca
                             verticalRed
                             ret

funcionAlfombra endp

calculateTableroBicho proc near
                             xor            ax,ax
                             xor            bx,bx
                             xor            dx,dx
                            
                             mov            al, FILBi
                             mov            bx, 3
                             mul            bx
                             add            ax, 1
                             xor            ah,ah
                             mov            dl, al
                             push           dx

                             xor            ax, ax
                             xor            bx,bx
                             mov            al, COLBi
                             mov            bx, 6
                             mul            bx
                             add            ax,3
                             xor            ah,ah
                             pop            dx
                             mov            dh,al
                             ret
calculateTableroBicho endp

calculateBicho proc near
                             xor            si,si
                             xor            ax,ax
                             mov            al, FILBi
                             mov            bx, 480
                             mul            bx
                             add            ax, 166
                             mov            dx,ax
                             push           dx
                             xor            ax,ax
                             xor            bx,bx

                             mov            al, COLBi
                             mov            bl, 12
                             mul            bx
                             pop            dx
                             add            ax,dx
                             mov            si,ax
                             ret
calculateBicho endp


funcionBichoAbajo proc

	;Cambiar direcciones bicho
			     ;mov fila, 3
			     ;mov columna, 3

                             call           calculateBicho
                            
                             ;mov            ah, roja
                             BICHOMACRO

                             call           calculateTableroBicho
                             ;mov            bh, roja
                             mov            bl, blanca
                             BICHOABAJO			  

                             ret

funcionBichoAbajo endP

funcionBichoArriba proc

	;Cambiar direcciones bicho
			     ;mov fila, 3
			     ;mov columna, 3

                             call           calculateBicho
                             
                             ;mov            ah, roja
                             BICHOMACRO

                             call           calculateTableroBicho
                             ;mov            bh, roja
                             mov            bl, blanca
                             BICHOARRIBA			 

                             ret

funcionBichoArriba endP

funcionBichoDerecha proc

	;Cambiar direcciones bicho

			     ;mov fila, 3
			     ;mov columna, 3

                             call           calculateBicho
                             
                             ;mov            ah, roja
                             BICHOMACRO

                             call           calculateTableroBicho
                             ;mov            bh, roja
                             mov            bl, blanca
                             BICHODERECHA

                             ret

funcionBichoDerecha endP

funcionBichoIzquierda proc

	;Cambiar direcciones bicho

			     ;mov fila, 3
			     ;mov columna, 3

                             call           calculateBicho
                            
                             ;mov            ah, roja
                             BICHOMACRO

                             call           calculateTableroBicho
                             ;mov            bh, roja
                             mov            bl, blanca
                             BICHOIZQUIERDA

                             ret

funcionBichoIzquierda endP


verificarMatrixC proc near                                                      ;Verifica si Existe y lo crea
                             xor            dx,dx
                             lea            dx,nombArchivoC
                             mov            ax,3D00h
                             int            21h
                             jnc            existenteError1

    crearPartida1:           mov            ah,3Ch                              ;Crea la nueva partida
                             xor            cx,cx
                             lea            dx, nombArchivoC
                             int            21h
                             jc             errorSobreEcribir1
                             mov            handleS,ax
                             jmp            escribirTableroNuevo1
   
    existenteError1:         mov            ah, 09h                             ;Pregunta si quiere que se reinicie
                             lea            dx, inputArchivoC
                             int            21h
                        
                             mov            ah,01h
                             int            21h
                             cmp            al, 89                              ;La tecla Y es la confirmacion
                             je             crearPartida1
                             jmp            errorSobreEcribir1
   
    escribirTableroNuevo1:   mov            bx, handleS                         ;Escribe el labero con los puntos
                             mov            ah, 40h
                             mov            cx,55
                             lea            dx,matrizOriginal
                             int            21h

    cerrarTableroCreado1:    mov            ah,3Eh                              ;Cierra el tablero
                             mov            bx,handleS
                             int            21h
                               
                             ret

    errorSobreEcribir1:      lea            dx, msgNoSobrescribir
                             mov            ah, 09h
                             int            21h

                             mov            ax,4C00h
                             int            21h
verificarMatrixC endp

verificarMatrixP proc near                                                      ;Verifica si Existe y lo crea
                             lea            dx,nombArchivoP
                             mov            ax,3D00h
                             int            21h
                             jnc            existenteError2

    crearPartida2:           mov            ah,3Ch                              ;Crea una nueva partida
                             xor            cx,cx
                             lea            dx, nombArchivoP
                             int            21h
                             jc             errorSobreEcribir2
                             mov            handleS,ax
                             jmp            escribirTableroNuevo2
   
    existenteError2:         mov            ah, 09h                             ;Pregunta si se quiere sobreescribir
                             lea            dx, inputArchivoP
                             int            21h
                        
                             mov            ah,01h
                             int            21h
                             cmp            al, 89                              ;La tecla Y es la confirmacion
                             je             crearPartida2
                             jmp            errorSobreEcribir2
   
    escribirTableroNuevo2:   mov            bx, handleS
                             mov            ah, 40h
                             mov            cx,55
                             lea            dx,matrizOriginal
                             int            21h

    cerrarTableroCreado2:    mov            ah,3Eh
                             mov            bx,handleS
                             int            21h
                               
                             ret

    errorSobreEcribir2:      lea            dx, msgNoSobrescribir
                             mov            ah, 09h
                             int            21h

                             mov            ax,4C00h
                             int            21h
verificarMatrixP endp

actualizarColores proc near                                                     ;Lee el archivo de colores y lo guarda en una variable

    converterMatriz1:        xor            di,di
                             mov            ah, 3Dh
                             xor            al, al
                             lea            dx, nombArchivoC
                             int            21h
                             jnc            followInsert1
                             jmp            error1

    followInsert1:           mov            handleS, ax
                             mov            cx,1
                             mov            bx, handleS

    readFileInsertar1:       mov            ah, 3Fh                             ;Lee el archivo
                             lea            dx, BuffyC
                             mov            bx, handleS
                             int            21h
                             jc             error1
                             jmp            writeTxt1
                                
    writeTxt1:               cmp            ax,0                                ;Escribe byte por byte lo que hay adentro
                             je             finalInsert1
                             mov            al, BuffyC
                             cmp            al, 10
                             je             readFileInsertar1
                             cmp            al, 13
                             je             readFileInsertar1
                             mov            byte ptr matrizActualC[di], al
                             mov            byte ptr matrizTemporalC[di], al    ;Creo que se pueden borrar
                             inc            di
                             jmp            readFileInsertar1

    error1:                  lea            dx, msgUpdateFail
                             mov            ah, 09h
                             int            21h

    finalInsert1:            mov            ah,3Eh
                             mov            bx,handleS
                             int            21h
                             ret

actualizarColores endp

actualzarPosiciones proc near                                                   ;Abre el archivo de las pociciones y lo copia en una variable

    converterMatriz2:        xor            di,di
                             mov            ah, 3Dh
                             xor            al, al
                             lea            dx, nombArchivoP
                             int            21h
                             jnc            followInsert2
                             jmp            error2

    followInsert2:           mov            handleP, ax
                             mov            cx,1
                             mov            bx, handleP

    readFileInsertar2:       mov            ah, 3Fh                             ;Lee el archivo y lo copia byte por byte
                             lea            dx, BuffyP
                             mov            bx, handleP
                             int            21h
                             jc             error2
                             jmp            writeTxt2
                                
    writeTxt2:               cmp            ax,0
                             je             finalInsert2
                             mov            al, BuffyP
                             cmp            al, 10
                             je             readFileInsertar2
                             cmp            al, 13
                             je             readFileInsertar2
                             mov            byte ptr matrizActualP[di], al
                             mov            byte ptr matrizTemporalP[di], al
                             inc            di
                             jmp            readFileInsertar2

    error2:                  lea            dx, msgUpdateFail
                             mov            ah, 09h
                             int            21h

    finalInsert2:            mov            ah,3Eh
                             mov            bx,handleS
                             int            21h
                             ret
actualzarPosiciones endp

buscaPosition proc near                                                         ;Una formula para buscar posision en matriz
                             xor            ax,ax
                             mov            al, fila
                             mov            bl, 7
                             mul            bx
                             mov            dl, columna
                             add            al,columna
                             mov            di,ax
                             ret
buscaPosition endp

buscaPosicionColor proc near                                                    ;Busca posicion en matriz de poicsiones
                             call           buscaPosition
                             mov            al, byte ptr matrizActualC[di]
                             mov            colorLeido , al
                             xor            bx,bx
                             ret
buscaPosicionColor endp

buscaPosicionPos proc near                                                      ;Busca la valor en matirz pocisiones
                             call           buscaPosition
                             mov            al, byte ptr matrizActualP[di]
                             mov            pocisionLeida,al
                             xor            bx,bx
                             ret
buscaPosicionPos endp

Randomize Proc
                             push           ax
                             push           cx
                             push           dx

                             mov            ah, 2Ch
                             int            21h
                             mov            word ptr Semilla, dx

                             pop            dx
                             pop            cx
                             pop            ax
                             ret
Randomize EndP

Random Proc
                             push           dx
                             mov            ax, Semilla
                             inc            ax
                             inc            ax
                             mul            ax
                             xchg           ah, al
                             mov            Semilla, ax

                             xor            dx, dx
                             div            bx

                             mov            ax, dx

                             pop            dx

                             ret
Random Endp

direccionHasamValidacion proc near
    ;Valida que la direccion de hasam no se invalida
    ;DNCP es la direccion actual de Hasam
                             mov            al, DNPC
                             cmp            DNPC, 0
                             je             validacionArriba
                             cmp            DNPC, 1
                             je             validacionDerecha
                             cmp            DNPC,2
                             je             validacionAbajo
                            
                             jmp            validacionIzquierda

    validacionArriba:        cmp            DNPCA, 2
                             jne            direccionCorrecta
                             jmp            direccionIncorrecta

    validacionDerecha:       cmp            DNPCA, 3
                             jne            direccionCorrecta
                             jmp            direccionIncorrecta
                             
    validacionAbajo:         cmp            DNPCA, 0
                             jne            direccionCorrecta
                             jmp            direccionIncorrecta

    validacionIzquierda:     cmp            DNPCA, 1
                             jne            direccionCorrecta
                             jmp            direccionIncorrecta


    direccionCorrecta:       mov            DNPCA, al
                             ret

    direccionIncorrecta:     mov            ax,4C00h
                             int            21h
direccionHasamValidacion endp

dadoLanzar proc near

                             call           Randomize
                             mov            bx, 6
                             call           Random

                             cmp            al, 2
                             jb             valor2
                             cmp            al, 3
                             ja             valor3
                             cmp            al, 2
                             je             valor1
                             mov            al, 4
                             ret

    valor1:                  mov            al, 1
                             ret
    valor2:                  mov            al, 2
                             ret
    valor3:                  mov            al,3
                             ret
           
dadoLanzar endp


movimientoBicho proc near
                             
                             call           dadoLanzar
                             mov            dado, al
			     mov	    ResDado, al
			     add ResDado, 48
			     mov al, byte ptr ResDado
			     mov byte ptr ResultDado[20], al

    ;  mov    al, 5                               ; filas
    ;  mov    ah, 2                               ; colu
    ;  mov    NPC, ax                             ;Se guarda pal muñe
                             ret


movimientoBicho endp


tomaDatos proc near                                                             ;Simula la recoleccion de datos para las validaciones

                             mov            fila, 5

                             mov            columna, 6
                             mov            columnaAux, 6


                             mov            direccion, 'V'


                             mov            colorP, 'Y'

                             ret
tomaDatos endp

validacionPersonaje proc near
                             mov            ax, NPC
                             mov            varY, ah
                             mov            varX, al

                             cmp            al, fila
                             jne            validacionCorrecta
                             cmp            ah, columna
                             jne            validacionCorrecta

                             mov            ah, 09h
                             lea            dx, msgEPosicion
                             int            21h
                             call           cerrarArchivos

    validacionCorrecta:      
                             ret


validacionPersonaje endp

validacionZonaAlfombra proc near                                                ;Valida posision alfombra
                             cmp            direccion, 'V'
                             je             validacionVertical
                             cmp            direccion, 'H'
                             je             validacionHorizontal
                             jmp            direccionInvalida
                           
    validacionVertical:      cmp            fila, 0
                             je             direccionInvalida

                             call           buscaPosicionPos
                             cmp            al, 'V'
                             jne            pocisionValidaAlfombra
                             call           buscaPosicionColor
                             mov            colorVerificacion,al

                             sub            fila ,1
                             call           buscaPosicionPos
                             cmp            al, 'V'
                             jne            pocisionValidaAlfombra
                             call           buscaPosicionColor
                             cmp            colorVerificacion, al
                             je             direccionInvalida
                             add            fila ,1
                             jmp            pocisionValidaAlfombra

    validacionHorizontal:    cmp            columna, 6
                             je             direccionInvalida
                             call           buscaPosicionPos
                             cmp            al, 'H'
                             jne            pocisionValidaAlfombra
                             call           buscaPosicionColor
                             mov            colorVerificacion, al

                             add            columna, 1
                             call           buscaPosicionPos
                             cmp            al, 'H'
                             jne            pocisionValidaAlfombra
                             call           buscaPosicionColor
                             cmp            colorVerificacion, al
                             je             direccionInvalida
                             sub            columna, 1
                          
    pocisionValidaAlfombra:  ret
             
    direccionInvalida:       lea            dx, msgDireccionE
                             mov            ah, 09h
                             int            21h

                             mov            ax, 4C00h
                             int            21h

validacionZonaAlfombra endp

insertarColor proc near                                                         ;Inserta un valor en la pocision
                           
                             mov            al, colorP
                             cmp            al, 'R'
                             je             colorValido
                             cmp            al, 'B'
                             je             colorValido
                             cmp            al, 'G'
                             je             colorValido
                             cmp            al, 'Y'
                             je             colorValido
                             jmp            colorInvalidoI

    colorValido:             call           buscaPosition
                             cmp            direccion, 'H'
                             je             insertHorizontal1
                             jmp            insertVertical1
    
    insertHorizontal1:       
                             mov            al, colorP
                             mov            byte ptr matrizActualC[di], al
                             mov            byte ptr matrizActualC[di+1], al
                             xor            di,di
                             ret
    
    insertVertical1:         
                             mov            al, colorP
                             mov            byte ptr matrizActualC[di], al
                             mov            byte ptr matrizActualC[di-7], al
                             xor            di,di
                             ret

    colorInvalidoI:          lea            dx, colorInvalido
                             mov            ah, 09h
                             int            21h

                             mov            ax, 4C00h
                             int            21h
insertarColor endp

insertarPosicion proc near                                                      ;Inserta un valor en la pocision
                             call           buscaPosition
                             mov            al, direccion
                             cmp            direccion, 'H'
                             je             insertHorizontal
                             jmp            insertVertical

    insertVertical:          mov            byte ptr matrizActualP[di], al
                             mov            byte ptr matrizActualP[di-7], al
                             xor            di,di
                             ret

    insertHorizontal:        mov            byte ptr matrizActualP[di], al
                             mov            byte ptr matrizActualP[di+1], al
                             xor            di,di
                             ret

    posInvalida:             lea            dx, posicionInvalida
                             mov            ah, 09h
                             int            21h

                             mov            ax, 4C00h
                             int            21h
insertarPosicion endp

cerrarArchivoC proc near
                             xor            si,si
                             xor            di,di

    restartBx10:             mov            bx,7

                             mov            cx,49
    loopInsertDi:            cmp            bx, 0
                             je             addBx
                             mov            al, byte ptr matrizActualC[si]
                             mov            byte ptr BuffyC[di], al
                             inc            di
                             inc            si
                             dec            bx
                             loop           loopInsertDi

    addBx:                   cmp            si, 49
                             je             createToFile
                             mov            byte ptr BuffyC[di], 10
                             inc            di
                             jmp            restartBx10
                                

    createToFile:            mov            ah, 3Ch
                             lea            dx, nombArchivoC
                              
                             xor            cx, cx
                             int            21h
                             jc             auxErrorSobre
                             mov            handleS, ax

                             mov            cx, 55
                             lea            dx, BuffyC
                             mov            bx, handleS

                             mov            ah, 40h
                             int            21h
                             jc             auxErrorSobre
                             jmp            cerrar

    auxErrorSobre:           lea            dx, msgETablero
                             mov            ah, 09h
                             int            21h

                             jmp            salirC

    cerrar:                  
                             mov            ah, 3Eh                             ; cerrar el archivo
                             mov            bx, handleS
                             int            21h
                             jmp            salirC
    salirC:                  
                             ret
cerrarArchivoC endp

cerrarArchivoP proc near
                             xor            si,si
                             xor            di,di

    restartBx102:            mov            bx,7

                             mov            cx,49
    loopInsertDi2:           cmp            bx, 0
                             je             addB2x2
                             mov            al, byte ptr matrizActualP[si]
                             mov            byte ptr BuffyP[di], al
                             inc            di
                             inc            si
                             dec            bx
                             loop           loopInsertDi2

    addB2x2:                 cmp            si, 49
                             je             createToFile2
                             mov            byte ptr BuffyP[di], 10
                             inc            di
                             jmp            restartBx102
                                

    createToFile2:           mov            ah, 3Ch
                             lea            dx, nombArchivoP
                              
                             xor            cx, cx
                             int            21h
                             jc             auxErrorSobre2
                             mov            handleP, ax

                             mov            cx, 55
                             lea            dx, BuffyP
                             mov            bx, handleP

                             mov            ah, 40h
                             int            21h
                             jc             auxErrorSobre2
                             jmp            cerrar2

    auxErrorSobre2:          lea            dx, msgETablero
                             mov            ah, 09h
                             int            21h

                             jmp            salirP
    cerrar2:                 
                             mov            ah, 3Eh
                             mov            bx, handleP
                             int            21h
                             jmp            salirP
    salirP:                  
                             ret
cerrarArchivoP endp

cerrarArchivos proc near
                             call           cerrarArchivoC
                             call           cerrarArchivoP

                             mov            ax, 4C00h
                             int            21h
cerrarArchivos endp

llamadaCrearArchivos proc near
                             call           actualzarPosiciones                 ;Retoma datos de colores

                             call           actualizarColores                   ;Retoma datos pocisiones

                             call           tomaDatos                           ;Simula recoleccion de variables

                             call           direccionHasamValidacion            ;Verifica direccion hasam

                             call           movimientoBicho

                            
                             call           validacionPersonaje                 ;valida alfombra con personaje

                             call           validacionZonaAlfombra              ;Zona alformbra

                             call           insertarColor                       ;Inserta color en matriz
                             call           insertarPosicion

                             call           cerrarArchivos                      ;LLamada para cerrar ejecucion y archivos

                             ret
llamadaCrearArchivos endp

crearNuevoTablero proc near
                             call           verificarMatrixC
                             call           verificarMatrixP
                             ret
crearNuevoTablero endp

FuncionesMenu proc

                             push           ax
                             push           bx
                             push           cx
                             push           dx
                             push           di
                             push           si
                             push           es

    revisartecla:            
    ;INTERRUPCION DE TECLADO
                             MOV            AH,01H
                             INT            16H
                             JZ             auxilio
                             JMP            HAYTECLA
    auxilio:                 jmp            revisartecla                        ;HAYTECLA ;salir;JMP DESPLEGAR ; Algor

    ALGOR:                   
                             mov            byte ptr Fil, 21                    ;Solo rotulos
                             mov            byte ptr Col, 0
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo4
                             call           prnRot
                             mov            byte ptr Fil, 22
                             mov            byte ptr Col, 0
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo4
                             call           prnRot
                             mov            byte ptr Fil, 23
                             mov            byte ptr Col, 0
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo4
                             call           prnRot
                             mov            byte ptr Fil, 24
                             mov            byte ptr Col, 0
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo4
                             call           prnRot


                             CMP            DIR, 0                              ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE1
                             JMP            CERO
    PREGUNTE1:               CMP            DIR, 1                              ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE2
                             JMP            UNO
    PREGUNTE2:               CMP            DIR, 2                              ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE3
                             JMP            DOS
    PREGUNTE3:               CMP            DIR, 3                              ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE4
                             JMP            TRES
    PREGUNTE4:               CMP            DIR, 4                              ; Con saltos de conejo pues ya da fuera de rango
                             JNE            PREGUNTE5
                             JMP            CUATRO
    PREGUNTE5:               CMP            DIR, 5
                             JNE            PREGUNTE6
                             JMP            CINCO
    PREGUNTE6:               CMP            DIR, 6
                             JNE            PREGUNTE7
                             JMP            SEIS
    PREGUNTE7:               CMP            DIR, 7
                             JNE            PREGUNTE8
                             JMP            SIETE
    PREGUNTE8:               Jmp            salir


    CERO:                    
                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo5
                             call           prnRot
                             mov            byte ptr Fil, 22
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo6
                             call           prnRot
                             mov            byte ptr Fil, 23
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo7
                             call           prnRot

                             jmp            salir

    UNO:                     

                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo1
                             call           prnRot
                             mov            byte ptr Fil, 22
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo2
                             call           prnRot
                             mov            byte ptr Fil, 23
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo3
                             call           prnRot

                             jmp            salir

    DOS:                     
                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo8
                             call           prnRot

                             jmp            salir

    TRES:                    
                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo9
                             call           prnRot

                             mov            byte ptr RotD1[0], '0'
                             mov            byte ptr RotD1[1], '3'
                             mov            byte ptr RotD1[2], '0'
                             mov            byte ptr RotA1[0], '1'
                             mov            byte ptr RotA1[1], '5'

                             jmp            salir

    CUATRO:                  


                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo10
                             call           prnRot

                             mov            byte ptr RotD2[0], '0'
                             mov            byte ptr RotD2[1], '3'
                             mov            byte ptr RotD2[2], '0'
                             mov            byte ptr RotA2[0], '1'
                             mov            byte ptr RotA2[1], '5'

                             jmp            salir

    CINCO:                   


                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo11
                             call           prnRot

                             mov            byte ptr RotD3[0], '0'
                             mov            byte ptr RotD3[1], '3'
                             mov            byte ptr RotD3[2], '0'
                             mov            byte ptr RotA3[0], '1'
                             mov            byte ptr RotA3[1], '5'

                             jmp            salir

    SEIS:                    

                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo12
                             call           prnRot

                             mov            byte ptr RotD4[0], '0'
                             mov            byte ptr RotD4[1], '3'
                             mov            byte ptr RotD4[2], '0'
                             mov            byte ptr RotA4[0], '1'
                             mov            byte ptr RotA4[1], '5'

                             jmp            salir

    SIETE:                   

                             mov            byte ptr Fil, 21
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo13
                             call           prnRot

                             call           Bicho

                             jmp            salir

    ;PROCESA LA TECLA DE FUNCION EXTENDIDA
    HAYTECLA:                

                             XOR            AH,AH
                             INT            16H
                             CMP            AL,'x'                              ;Se sale con una x minuscula
                             JZ             fin1
                             jmp            REVISE_DIR
    fin1:                    jmp            fin
			

    REVISE_DIR:                                                                 ;CMP AH,47H	;SI ES HOME
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
    S4:                                                                         ;CMP AH,1C	;SI ES A
                             cmp            al, 'A'
                             JNZ            S5
                             MOV            DIR,0
                             JMP            salircambiodir
    S5:                                                                         ;CMP AH,32	;SI ES B
                             cmp            al, 'B'
                             JNZ            S6
                             MOV            DIR,1
                             JMP            salircambiodir
    S6:                                                                         ;CMP AH,21	;SI ES C
                             cmp            al, 'C'
                             JNZ            S7
                             MOV            DIR,2
                             JMP            salircambiodir
    S7:                                                                         ;CMP AH,23	;SI ES D
                             cmp            al, 'D'
                             JNZ            S8
                             MOV            DIR,3
                             JMP            salircambiodir
    S8:                                                                         ;CMP AH,24	;SI ES E
                             cmp            al, 'E'
                             JNZ            S9
                             MOV            DIR,4
                             JMP            salircambiodir
    S9:                                                                         ;CMP AH,2B	;SI ES F
                             cmp            al, 'F'
                             JNZ            S10
                             MOV            DIR,5
                             JMP            salircambiodir
    S10:                                                                        ;CMP AH,34	;SI ES G
                             cmp            al, 'G'
                             JNZ            S11
                             MOV            DIR,6
                             JMP            salircambiodir
    S11:                                                                        ;CMP AH,33	;SI ES H
                             cmp            al, 'H'
                             JNZ            S12
                             MOV            DIR,7
                             JMP            salircambiodir
    S12:                     
      
     
    salircambiodir:          jmp            algor                               ; jmp desplegar


    salir:                   
    ;                   mov            ah, 09h
    ;                   lea            dx, Rotulo14
    ;                   int            21h

                             mov            byte ptr Fil, 24
                             mov            byte ptr Col, 1
                             mov            dl, Fil
                             mov            dh, Col
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
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
                             mov            byte ptr ColB, 01000100b
                             mov            byte ptr ColF, 07Fh
                             mov            bh, ColB
                             mov            bl, ColF
                             lea            si, Rotulo15
                             call           prnRot

                             Tecla
                             mov            ax, 03h                             ; borra la pantalla reiniciando el modo texto a 80x25 a 16 colores
                             int            10h


                             pop            es
                             pop            si
                             pop            di
                             pop            dx
                             pop            cx
                             pop            bx
                             pop            ax
                             ret



FuncionesMenu endP

                       
    main:                    push           ds
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

    ;call           funcionAlfombra

    ;Tecla
                             call           FuncionesMenu
    
                             mov            ax, 4C00h                           ; protocolo de finalización del programa.
                             int            21h

codigo ends

end main        