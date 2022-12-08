#   How to read and write files
#   ... 

.data
newline:             .asciz "\n"
fileName1:      .asciz "input.csv"       # 
fileName2:      .asciz "output.txt"      # 

buffer:           .space 0x8000
fileHandle1: .word 0x0
fileHandle2: .word 0x0

         
  .text
  
  li   s3, 0
  li   s9, 1

  
  li   a7, 1024           # open a file
  la   a0, fileName1        # ... the name
  li   a1, 0                # ... for reading
  ecall                     # 
  la   t1, fileHandle1      # the address of the file handle
  sw   a0, (t1)             # save the handle ...
  

  li   a7, 1024           # open a file
  la   a0, fileName2        # ... the name
  li   a1, 1                # ... for writing
  ecall                     # 
  la   t1, fileHandle2      # the address of the file handle
  sw   a0, (t1)             # save the handle


# ; 0x3B
  ciklas:
  li s3, 0
  li t6, 1
  li s9, 1
  readNextByteFirstField:
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            


  ble a0, x0, endOfLoop
  
  li t6, 0x3b
  la t5, buffer
  add t5, t5, s3
  lbu t5, (t5)
  addi s3, s3, 1
  
  bne t6, t5, readNextByteFirstField

  jal checkFirstField
  
  readNextByteSecondField:
  
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            


  ble a0, x0, endOfLoop
  
  li t6, 0x3B
  la t4, buffer
  add t4, t4, s3
  lbu a0, (t4)
    
  
  addi s3, s3, 1
  
  bne t6, a0, readNextByteSecondField
  
  li t3, 127
  readNextByteThirdField:  
  
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            


  ble a0, x0, endOfLoop
  

  la t4, buffer
  add t4, t4, s3
  lbu a0, (t4)
  li t6, 127
  bne t6, t3, notFirstTime
  li t3, 0
  li t6, 0x2D
  bne t6, a0, readToNextLine
  
  notFirstTime:
  li t6, 0x3B# 0x3B 0xA until I do the other fields
  
  addi s3, s3, 1
  
  bne t6, a0, readNextByteThirdField
  
  li s8, 1
  li s6, 0
  readNextByteFourthField:
  
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            


  ble a0, x0, endOfLoop
  
  li t6, 0x3B
  la t4, buffer
  add t4, t4, s3
  lbu a0, (t4)
  
  li t6, 0x2D
  bne a0, t6, nonegative
  li s8, -1
  j negative
  nonegative:
  
  li t6, 10
  li t5, 49
  beq t5, a0, uno
  li t5, 50
  beq t5, a0, dos
  li t5, 51
  beq t5, a0, tres
  li t5, 52
  beq t5, a0, cuatro
  li t5, 53
  beq t5, a0, cinco
  li t5, 54
  beq t5, a0, seis
  li t5, 55
  beq t5, a0, siete
  li t5, 56
  beq t5, a0, ocho
  li t5, 57
  beq t5, a0, nueve
  j negative
  
  uno:
  li t5, 1
  j multi
  dos:
  li t5, 2
  j multi
  tres:
  li t5, 3
  j multi
  cuatro:
  li t5, 4
  j multi
  cinco:
  li t5, 5
  j multi
  seis:
  li t5, 6
  j multi
  siete:
  li t5, 7
  j multi
  ocho:
  li t5, 8
  j multi
  nueve:
  li t5, 9
  j multi
  
  
  multi:
  
  mul s6, s6, t6
  add s6, t5, s6
  negative:
  
    
  li t6, 0x3B
  addi s3, s3, 1
  
  bne t6, a0, readNextByteFourthField

  mul s6, s6, s8
  li s8, 1
  li s7, 0
  readNextByteFifthField:
  
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            


  ble a0, x0, endOfLoop
  
  li t6, 0x3B
  la t4, buffer
  add t4, t4, s3
  lbu a0, (t4)
    
  li t6, 0x2D
  bne a0, t6, nonegative2
  li s8, -1
  j negative2
  nonegative2:
  
  li t6, 10
  li t5, 49
  beq t5, a0, uno2
  li t5, 50
  beq t5, a0, dos2
  li t5, 51
  beq t5, a0, tres2
  li t5, 52
  beq t5, a0, cuatro2
  li t5, 53
  beq t5, a0, cinco2
  li t5, 54
  beq t5, a0, seis2
  li t5, 55
  beq t5, a0, siete2
  li t5, 56
  beq t5, a0, ocho2
  li t5, 57
  beq t5, a0, nueve2
  j negative2
  
  uno2:
  li t5, 1
  j multi2
  dos2:
  li t5, 2
  j multi2
  tres2:
  li t5, 3
  j multi2
  cuatro2:
  li t5, 4
  j multi2
  cinco2:
  li t5, 5
  j multi2
  seis2:
  li t5, 6
  j multi2
  siete2:
  li t5, 7
  j multi2
  ocho2:
  li t5, 8
  j multi2
  nueve2:
  li t5, 9
  j multi2
  
  multi2:
  mul s7, s7, t6
  add s7, t5, s7
  negative2:
    
  
  addi s3, s3, 1
  li t6, 0x3B
  bne t6, a0, readNextByteFifthField
  
  mul s7, s7, s8
  sub t4, s6, s7
  
  li t3, 11
  
  rem t4, t4, t3
  
  beqz t4, readToNextLine
  
 readNextByteSixthField:
  
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            


  ble a0, x0, endOfLoop
  
  li t6, 0XA
  la t4, buffer
  add t4, t4, s3
  lbu a0, (t4)
    
  
  addi s3, s3, 1
  
  bne t6, a0, readNextByteSixthField
  
  
  
  la s4, buffer
  addi s4, s4, -1
  addi s3, s3, -1
  
  printConsole:
  addi s4, s4, 1      

  li a7, 11
  lbu a0, (s4)
  ecall
  
  la s5, buffer
  add s5, s3, s5
  bne s5, s4, printConsole
  
  li   a7, 64                       # write to file
  lw   a0, fileHandle2       
  la   a1, buffer
  addi a2, s3, 0                        # ... number of bytes to write
  ecall      
  
  j ciklas
  
  endOfLoop:
  
  
  
  
  li   a7, 57                      # close the file
  lw   a0, fileHandle1
  ecall
 
  li   a7, 57                      # close the file
  lw   a0, fileHandle2
  ecall


  
  endOfProgram:
  li   a7, 10
  ecall
  
  
  
  checkFirstField:
  addi t5, s3, -2
  
  la t4, buffer
  add t4, t4, t5
  lbu a0, (t4)
  li t1, 0x41 
  bne t1, a0, readToNextLine
  
  addi t5, t5, -1

  la t4, buffer
  add t4, t4, t5
  lbu a0, (t4)
  li t1, 0x41
  bne t1, a0, readToNextLine
  bne x0, t5, readToNextLine
  
  jr x1
  
  
  readToNextLine:
  
  li   a7, 63                       # read a file
  lw   a0, fileHandle1       
  la   a1, buffer                  # ... buffer for data
  add a1, a1, s3
  li   a2, 1                        # ... number of bytes to read
  ecall            

  li s9, 0

  ble a0, x0, endOfLoop
  
  la t4, buffer
  add t4, t4, s3
  lbu a0, (t4)
  
  addi s3, s3, 1
  li t3, 0xA
  bne t3, a0, readToNextLine
  
  li s3, 0
  
  
  
  j ciklas
