; var 1
.686
.model flat, stdcall
include c:\masm32\include\masm32rt.inc
include c:\masm32\include\fpu.inc
includelib c:\masm32\lib\fpu.lib

ExitProcess proto :dword ;Что-то про выход из процесса с использованием dword как максимального формата

.data
	x           dt ?
	a           dt ?
	bracketx2   dt ?
	numerator   dt ?
	denominator dt ?
	fifteen     dt 15.0
	six         dt 6.0
	thirtyfour  dt 34.0
	two         dt 2.0
	sixteen     dt 16.0
	eight       dt 8.0
	fourteen    dt 14.0
	res         dt ?
	outbuff     db 30 dup(?)
	inbuff      db 30 dup(?)
	skip        db 0dh,0ah

.code
	start:      
	            invoke StdIn, ADDR inbuff, 100                                    	;Ввод первого числа
	            invoke FpuAtoFL, ADDR inbuff, ADDR x, DEST_MEM                    	;Перевод полученной строки в вещественную переменную для x
	            invoke StdIn, ADDR inbuff, 100
	            invoke FpuAtoFL, ADDR inbuff, ADDR a, DEST_MEM

	            FLD    x
	            FLD    two
	            FMUL

	            FLD    thirtyfour
	            FSUBR

	            FLD    two
	            FMUL

	            FSTP   bracketx2

	            FLD    fifteen
	            FCHS
	            FLD    six
	            FDIV

	            FLD    bracketx2
	            FADD

	            FSTP   numerator

	            FLD    a
	            FSIN

	            FLD    eight
	            FDIV

	            FLD    sixteen
	            FADD

	            FSTP   denominator

	            FLD    numerator
	            FLD    denominator
	            FDIV

	            FLD    fourteen
	            FSUB

	            FSTP   res

	            invoke FpuFLtoA, ADDR res, 5, ADDR outbuff, SRC1_REAL or SRC2_DIMM	;Преобразовывает цисло в строку outbuf
	;последние два параметра - источник в памяти или 32-битное беззнаковое целое
	            invoke StdOut, ADDR outbuff                                       	;Вывод строки
	            invoke StdOut, ADDR skip
	            jmp    exitprogram

	exitprogram:
	            inkey                                                             	;Приглашение нажать любую кнопку
	            push   0
	            invoke ExitProcess, 0

end start
