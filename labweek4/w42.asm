.text
li $s0, 0x012345678
andi $t0, $s0, 0xff000000 #extract msb of $s0
andi $t1, $s0, 0xffffff00 #clear lsb of $s
ori $t2, $s0, 0x000000ff #set lsb of $s0
andi $t4, $s0, 0x00000000