global riscv2:function
extern printf

section .text
riscv2:
	push rbx
    mov     rbx, rdi	; rbx = char* text
    mov     r10, rsi    ; r10 = FILE* fout


	.loopLine:	
		xor	rax, rax	; rax = 0
		xor	rdx, rdx 	; rdx = aux for reading ascii number
		xor	rcx, rcx	; rcx= is negative?
		inc rcx
		xor	r8, r8		; r8 = is first time in field
		xor	r9, r9		; r9 = A count firstField
		xor	r10, r10	; r10 = fourthField value
		xor	r11, r11	; r11 = fifthField value

		.readNextByteFirstField:
			cmp byte[rbx], 0x41
			jne .noA
			inc r9
			.noA:
			cmp	byte[rbx], 0x3B
			inc rbx
			jne .readNextByteFirstField

			cmp r9, 0x2
			jne .noPrint

		.readNextByteSecondField:
			cmp byte[rbx], 0x3B
			inc rbx
			jne .readNextByteSecondField

			add r8, 0xF
		.readNextByteThirdField:
			cmp r8, 0xF
			jne .notFirstTimeThird
			cmp byte[rbx], 0x2D
			inc r8
			inc rbx
			jne .noPrint
			j .readNextByteThirdField
			.notFirstTimeThird:
			cmp byte[rbx], 0x3B
			inc rbx
			jne .readNextByteThirdField

			xor r8, r8
			add r8, 0xF
		.readNextByteFourthField:
			cmp r8, 0xF
			jne .notFirstTimeFourth
			cmp byte[rbx], 0x2D
			inc r8
			inc rbx
			dec rcx
			dec rcx
			j .readNextByteFourthField

			.notFirstTimeFourth:

			cmp byte[rbx], 0x30
			jeq .zeroFourth
			cmp byte[rbx], 0x31
			jeq .oneFourth
			cmp byte[rbx], 0x32
			jeq .twoFourth
			cmp byte[rbx], 0x33
			jeq .threeFourth
			cmp byte[rbx], 0x34
			jeq .fourFourth
			cmp byte[rbx], 0x35
			jeq .fiveFourth
			cmp byte[rbx], 0x36
			jeq .sixFourth
			cmp byte[rbx], 0x37
			jeq .sevenFourth
			cmp byte[rbx], 0x38
			jeq .eightFourth
			cmp byte[rbx], 0x39
			jeq .nineFourth

			j .noPrint

			.zeroFourth:
			xor rdx, rdx
			add rdx, 0
			j .mulFourth

			.oneFourth:
			xor rdx, rdx
			add rdx, 1
			j .mulFourth

			.twoFourth:
			xor rdx, rdx
			add rdx, 2
			j .mulFourth

			.threeFourth:
			xor rdx, rdx
			add rdx, 3
			j .mulFourth

			.fourFourth:
			xor rdx, rdx
			add rdx, 4
			j .mulFourth

			.fiveFourth:
			xor rdx, rdx
			add rdx, 5
			j .mulFourth

			.sixFourth:
			xor rdx, rdx
			add rdx, 6
			j .mulFourth

			.sevenFourth:
			xor rdx, rdx
			add rdx, 7
			j .mulFourth

			.eightFourth:
			xor rdx, rdx
			add rdx, 8
			j .mulFourth

			.nineFourth:
			xor rdx, rdx
			add rdx, 9
			j .mulFourth

			.mulFourth:

			xor al, al
			add al, 10
			mul r10
			mov r10, ax
			add r10, rdx

			inc rbx


			cmp byte[rbx], 0x3B
			inc rbx
			jne .readNextByteFourthField

			mov al, rcx
			mul r10
			mov r10, ax

			xor r8, r8
			add r8, 0xF
			xor rcx, rcx
			inc rcx
		.readNextByteFifthField:
			cmp r8, 0xF
			jne .notFirstTimeFifth
			cmp byte[rbx], 0x2D
			inc r8
			inc rbx
			dec rcx
			dec rcx
			j .readNextByteFifthField

			.notFirstTimeFifth:

			cmp byte[rbx], 0x30
			jeq .zeroFifth
			cmp byte[rbx], 0x31
			jeq .oneFifth
			cmp byte[rbx], 0x32
			jeq .twoFifth
			cmp byte[rbx], 0x33
			jeq .threeFifth
			cmp byte[rbx], 0x34
			jeq .fourFifth
			cmp byte[rbx], 0x35
			jeq .fiveFifth
			cmp byte[rbx], 0x36
			jeq .sixFifth
			cmp byte[rbx], 0x37
			jeq .sevenFifth
			cmp byte[rbx], 0x38
			jeq .eightFifth
			cmp byte[rbx], 0x39
			jeq .nineFifth

			j .noPrint

			.zeroFifth:
			xor rdx, rdx
			add rdx, 0
			j .mulFifth

			.oneFifth:
			xor rdx, rdx
			add rdx, 1
			j .mulFifth

			.twoFifth:
			xor rdx, rdx
			add rdx, 2
			j .mulFifth

			.threeFifth:
			xor rdx, rdx
			add rdx, 3
			j .mulFifth

			.fourFifth:
			xor rdx, rdx
			add rdx, 4
			j .mulFifth

			.fiveFifth:
			xor rdx, rdx
			add rdx, 5
			j .mulFifth

			.sixFifth:
			xor rdx, rdx
			add rdx, 6
			j .mulFifth

			.sevenFifth:
			xor rdx, rdx
			add rdx, 7
			j .mulFifth

			.eightFifth:
			xor rdx, rdx
			add rdx, 8
			j .mulFifth

			.nineFifth:
			xor rdx, rdx
			add rdx, 9
			j .mulFifth

			.mulFifth:

			xor al, al
			add al, 10
			mul r11
			mov r11, ax
			add r11, rdx

			inc rbx


			cmp byte[rbx], 0x3B
			inc rbx
			jne .readNextByteFifthField

			mov al, rcx
			mul r11
			mov r11, ax

			mov dx, 0
			mov ax, r10
			div r11
			cmp dx, 0
			jeq .noPrint

		.readNextByteSixthField:
			cmp byte[rbx], 0x3B
			inc rbx
			jne .readNextByteSecondField

	inc rax
	.noPrint:
		pop rbx
		ret

section .data
	asciiSemicolon	db	0x3B
	asciiA			db	0x41