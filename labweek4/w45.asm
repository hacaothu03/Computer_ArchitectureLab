.text
li $s0, 2	#s0 = 2
li $s1, -1	#s1 = 0 (i = -1)
li $s4, 1	#s4 = 1 (step = 1)
li $s5, 10	#s5 = 10 (n=10)

loop:
sllv $s6, $s0, $s1 	#s6 = 2*s^s1
add $s1, $s1, $s4 	#s1 = s1 + s4 (i = i + step)
bne $s1, $s5, loop 	#neu s1 < 10 thi goto loop