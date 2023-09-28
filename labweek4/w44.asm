.text
li $s1, 0x80000000 #s1 = 0x80000000
li $s2, -1000 #s2 = -1000
start:
li $t0, 0 #t0 = 0
addu $s3, $s1, $s2 #s3 = s1+s2
xor $t1, $s1, $s2 #t1 = s1 xor s2
bltz $t1, EXIT
xor $t2, $s1, $s3 #t2 = s1 xor s3
bltz $t2, OVERFLOW
j EXIT
OVERFLOW:
li $t0, 1 #t0 = 1
EXIT: