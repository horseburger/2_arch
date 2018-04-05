		.MODEL TINY
		.386P

.CODE

		ORG 	100h

Start:

		
		mov 	ah, PRINT_STR
		mov 	dx, OFFSET napisPierwszy
		int 	21h

		mov 	dx, OFFSET pierwszaLiczba
		mov 	ah, INPUT_STR
		int 	21h

		mov 	si, OFFSET pierwszaLiczba + 1
		mov 	cl, [si]
		xor		ch, ch
		mov 	si, OFFSET pLiczbaDane

		xor 	ax,ax

		mov 	al, [si]
		sub 	al, '0'
		inc 	si

		mov 	bx, 1
		cmp 	bx, cx
		je 		afterLoop1
		dec 	cx

changeLoop1:

		mov 	bl, [si]
		sub 	bl, '0'
		mov 	dx, MUL_CONST
		mul 	dl
		add 	al, bl
		inc 	si
		loop 	changeLoop1

afterLoop1:

		mov 	liczba1, ax

		mov 	ah, PRINT_STR
		mov 	dx, OFFSET napisDrugi
		int 	21h

		mov 	dx, OFFSET drugaLiczba
		mov 	ah, INPUT_STR
		int 	21h

		mov 	si, OFFSET drugaLiczba + 1
		mov 	cl, [si]
		xor 	ch, ch
		mov 	si, OFFSET dLiczbaDane

		xor 	ax,ax

		mov 	al, [si]
		sub 	al, '0'
		inc 	si

		mov 	bx, 1
		cmp 	bx, cx
		je 		afterLoop2
		dec 	cx

changeLoop2:
	
		mov 	bl, [si]
		sub 	bl, '0'
		mov 	dx, MUL_CONST
		mul 	dl
		add 	al, bl
		inc 	si
		loop 	changeLoop2	

afterLoop2:

		mov 	liczba2, ax

		mov 	bx, liczba1

		add 	ax, bx

		mov 	suma, ax
		mov 	si, OFFSET drugaLiczba + 1 
		mov 	bx, [si]
		mov 	si, OFFSET pierwszaLiczba + 1 
		mov 	ax, [si]
		cmp 	ax, bx
		mov 	cx, [si]
		xor 	ch, ch
		jl 		checkpoint
		jmp 	prePrintLoop

checkpoint:
		
		mov 	si, OFFSET drugaLiczba + 1
		mov 	cx, [si]

prePrintLoop:
	
		mov 	ah,PRINT_STR
		mov 	dx, OFFSET napisSuma
		int 	21h

		mov 	bx, MUL_CONST
		mov 	ax, suma
		xor 	dx,dx
		



		mov 	ah, 4Ch
		int 	21h


;		DANE 

		INPUT_STR			EQU 0Ah
		PRINT_STR			EQU 09h
		INPUT_LEN			EQU 7
		MUL_CONST			EQU 0Ah

		pierwszaLiczba		DB  INPUT_LEN
							DB (?)
		pLiczbaDane			DB INPUT_LEN DUP (?)

		drugaLiczba			DB  INPUT_LEN
							DB (?)
		dLiczbaDane			DB INPUT_LEN DUP (?)

		liczba1				DW 	(?)
		liczba2				DW 	(?)
		suma 				DW 	(?)

		napisPierwszy 		DB 	"Podaj pierwsza liczbe: ",13,10,"$"
		napisDrugi	 		DB 	"Podaj druga liczbe: ",13,10,"$"
		napisSuma			DB  "Wynik to: ",13,10,"$"
		napisLiczbySuma 	DB 	(?),32,"$"


		END 	Start



