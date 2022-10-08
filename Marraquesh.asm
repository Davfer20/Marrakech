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

datos endS

pila segment stack 'stack'
         dw 256 dup(?)
pila endS


codigo segment
                     Assume CS:codigo,DS:datos,SS:pila
                                 

    main:            mov    ax, ds
                     mov    es, ax
                     mov    ax, datos
                     mov    ds, ax
                     mov    ax, pila
                     mov    ss, ax
                                 
           
    terminarPrograma:mov    ax, 4C00h
                     int    21h
codigo ends

end main                                
