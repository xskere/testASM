global riscv2:function

section .text
riscv2:
	push rbx
    mov     rbx, rdi	; rbx = char* line


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
			jmp .readNextByteThirdField
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
			jmp .readNextByteFourthField

			.notFirstTimeFourth:

			cmp byte[rbx], 0x30
			je .zeroFourth
			cmp byte[rbx], 0x31
			je .oneFourth
			cmp byte[rbx], 0x32
			je .twoFourth
			cmp byte[rbx], 0x33
			je .threeFourth
			cmp byte[rbx], 0x34
			je .fourFourth
			cmp byte[rbx], 0x35
			je .fiveFourth
			cmp byte[rbx], 0x36
			je .sixFourth
			cmp byte[rbx], 0x37
			je .sevenFourth
			cmp byte[rbx], 0x38
			je .eightFourth
			cmp byte[rbx], 0x39
			je .nineFourth

			jmp .noPrint

			.zeroFourth:
			xor rdx, rdx
			add rdx, 0
			jmp .mulFourth

			.oneFourth:
			xor rdx, rdx
			add rdx, 1
			jmp .mulFourth

			.twoFourth:
			xor rdx, rdx
			add rdx, 2
			jmp .mulFourth

			.threeFourth:
			xor rdx, rdx
			add rdx, 3
			jmp .mulFourth

			.fourFourth:
			xor rdx, rdx
			add rdx, 4
			jmp .mulFourth

			.fiveFourth:
			xor rdx, rdx
			add rdx, 5
			jmp .mulFourth

			.sixFourth:
			xor rdx, rdx
			add rdx, 6
			jmp .mulFourth

			.sevenFourth:
			xor rdx, rdx
			add rdx, 7
			jmp .mulFourth

			.eightFourth:
			xor rdx, rdx
			add rdx, 8
			jmp .mulFourth

			.nineFourth:
			xor rdx, rdx
			add rdx, 9
			jmp .mulFourth

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
			jmp .readNextByteFifthField

			.notFirstTimeFifth:

			cmp byte[rbx], 0x30
			je .zeroFifth
			cmp byte[rbx], 0x31
			je .oneFifth
			cmp byte[rbx], 0x32
			je .twoFifth
			cmp byte[rbx], 0x33
			je .threeFifth
			cmp byte[rbx], 0x34
			je .fourFifth
			cmp byte[rbx], 0x35
			je .fiveFifth
			cmp byte[rbx], 0x36
			je .sixFifth
			cmp byte[rbx], 0x37
			je .sevenFifth
			cmp byte[rbx], 0x38
			je .eightFifth
			cmp byte[rbx], 0x39
			je .nineFifth

			jmp .noPrint

			.zeroFifth:
			xor rdx, rdx
			add rdx, 0
			jmp .mulFifth

			.oneFifth:
			xor rdx, rdx
			add rdx, 1
			jmp .mulFifth

			.twoFifth:
			xor rdx, rdx
			add rdx, 2
			jmp .mulFifth

			.threeFifth:
			xor rdx, rdx
			add rdx, 3
			jmp .mulFifth

			.fourFifth:
			xor rdx, rdx
			add rdx, 4
			jmp .mulFifth

			.fiveFifth:
			xor rdx, rdx
			add rdx, 5
			jmp .mulFifth

			.sixFifth:
			xor rdx, rdx
			add rdx, 6
			jmp .mulFifth

			.sevenFifth:
			xor rdx, rdx
			add rdx, 7
			jmp .mulFifth

			.eightFifth:
			xor rdx, rdx
			add rdx, 8
			jmp .mulFifth

			.nineFifth:
			xor rdx, rdx
			add rdx, 9
			jmp .mulFifth

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
			je .noPrint

		.readNextByteSixthField:
			cmp byte[rbx], 0x3B
			inc rbx
			jne .readNextByteSecondField

	inc rax
	.noPrint:
		pop rbx
		ret
