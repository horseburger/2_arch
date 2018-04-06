		.MODEL TINY



.CODE

		ORG 	100h

Start:

		mov 	NEGATIVE, 0
		mov 	ah, PRINT_STR
		mov 	dx, OFFSET napisPierwszy
		int 	21h

		mov 	dx, OFFSET pierwszaLiczba
		mov 	ah, INPUT_STR
		int 	21h

		mov 	dx, OFFSET NEW_LINE
		mov 	ah, PRINT_STR
		int 	21h

		mov 	si, OFFSET pierwszaLiczba + 1			; licznik
		mov 	cl, [si]
		mov 	temp, cl
		xor		ch, ch
		mov 	si, OFFSET pLiczbaDane
		mov 	al, [si]
		cmp 	al, '0'
		je 		blad1
		cmp 	al, '-'
		je 		minus1
		jmp 	errHandle1

minus1:

		mov 	NEGATIVE, 1
		dec 	cl
		mov 	temp, cl
		inc 	si

errHandle1:

		mov 	al, [si]
		cmp 	al, '0'
		jl 		blad1
		cmp 	al, '9'
		jg 		blad1
		inc 	si
		loop 	errHandle1
		jmp 	afterBlad1

blad1:

		mov 	ah, PRINT_STR
		mov 	dx, OFFSET errMsg
		int 	21h
		jmp 	Start

afterBlad1:

		mov 	si, OFFSET pierwszaLiczba + 1
		mov 	cl, [si]
		mov 	si, OFFSET pLiczbaDane
		xor 	bx, bx
		mov 	ax, [si]
		xor 	ah, ah
		cmp 	ax, '-'
		je 		tmpTmp1
afterTmpTmp1:		
		sub 	ax, '0'
		xor 	ah, ah
		cmp 	cl, 1
		je 		afterLoop1
		jmp 	changeLoop1

tmpTmp1:

		inc 	si
		dec 	cl
		mov 	ax, [si]
		jmp		afterTmpTmp1

tmp1:

		dec 	cl

changeLoop1:

		mov 	bl, [si]
		sub 	bl, '0'
		inc 	si
		cmp 	cl, temp
		je 		tmp1
		mov 	dx, MUL_CONST
		mul 	dx
		xor 	bh, bh
		add 	ax, bx
		loop 	changeLoop1
		jmp 	afterLoop1

U2_1:

		neg 	ax
		add 	ax, 1
		jmp 	afterAfterLoop1


afterLoop1:

		cmp 	NEGATIVE, 1
		je 		U2_1

afterAfterLoop1:

		mov 	liczba1, ax

afterError:


		mov 	NEGATIVE, 0	
		mov 	ah, PRINT_STR
		mov 	dx, OFFSET napisDrugi
		int 	21h

		mov 	dx, OFFSET drugaLiczba
		mov 	ah, INPUT_STR
		int 	21h

		mov 	dx, OFFSET NEW_LINE
		mov 	ah, PRINT_STR
		int 	21h

		mov 	si, OFFSET drugaLiczba + 1			; licznik
		mov 	cl, [si]
		mov 	temp, cl
		xor		ch, ch
		mov 	si, OFFSET dLiczbaDane
		mov 	al, [si]
		cmp 	al, '0'
		je 		blad2
		cmp 	al, '-'
		je 		minus2
		jmp 	errHandle2

minus2:

		mov 	NEGATIVE, 1
		dec 	cl
		mov 	temp, cl
		inc 	si

errHandle2:

		mov 	al, [si]
		cmp 	al, '0'
		jl 		blad2
		cmp 	al, '9'
		jg 		blad2
		inc 	si
		loop 	errHandle2
		jmp 	afterBlad2

blad2:

		mov 	ah, PRINT_STR
		mov 	dx, OFFSET errMsg
		int 	21h
		jmp 	afterError

afterBlad2:

		mov 	si, OFFSET drugaLiczba + 1
		mov 	cl, [si]
		mov 	si, OFFSET dLiczbaDane
		xor 	bx, bx
		mov 	ax, [si]
		xor 	ah, ah
		cmp 	ax, '-'
		je 		tmpTmp2
afterTmpTmp2:
		sub 	ax, '0'
		xor 	ah, ah
		cmp 	cl, 1
		je 		afterLoop2
		jmp 	changeLoop2

tmpTmp2:

		inc 	si
		dec 	cl
		mov 	ax, [si]
		jmp 	afterTmpTmp2

tmp2:

		dec 	cl

changeLoop2:

		mov 	bl, [si]
		sub 	bl, '0'
		inc 	si
		cmp 	cl, temp
		je 		tmp2
		mov 	dx, MUL_CONST
		mul 	dx
		add 	ah, bh
		loop 	changeLoop2
		jmp 	afterLoop2

U2_2:

		neg 	ax
		add 	ax, 1
		jmp 	afterAfterLoop2

afterLoop2:

		cmp 	NEGATIVE, 1
		je 		U2_2

afterAfterLoop2:

		mov 	liczba2, ax

		mov 	bx, liczba1

		add 	ax, bx

		mov 	suma, ax
		mov 	bx, MUL_CONST
		xor 	dx, dx
		xor 	cx, cx

preStringPrint:

		div 	bx
		push 	dx
		xor 	dx, dx
		inc 	cx
		cmp		ax, 0
		jne		preStringPrint

		mov 	ah, 02h

stringPrint:

		cmp 	cx, 0
		je 		koniec
		pop 	dx
		add 	dx, 30h
		int 	21h
		dec 	cx
		jmp 	stringPrint



koniec:

		mov 	ah, 4Ch
		int 	21h




;		DANE 

		INPUT_STR			EQU 0Ah
		NEW_LINE 			DB 	13,10,"$"
		PRINT_STR			EQU 09h
		PRINT_CHR			EQU 02h
		INPUT_LEN			EQU 7
		MUL_CONST			EQU 0Ah

		NEGATIVE 			DB 	(?)

		pierwszaLiczba		DB  INPUT_LEN
							DB (?)
		pLiczbaDane			DB INPUT_LEN DUP (?)

		drugaLiczba			DB  INPUT_LEN
							DB (?)
		dLiczbaDane			DB INPUT_LEN DUP (?)

		liczba1				DW 	(?)
		liczba2				DW 	(?)
		suma 				DW 	(?)

		temp				DB 	(?)

		napisPierwszy 		DB 	"Podaj pierwsza liczbe: ",13,10,"$"
		napisDrugi	 		DB 	"Podaj druga liczbe: ",13,10,"$"
		errMsg 				DB 	"Niepoprawne dane",13,10,"$"


		END 	Start