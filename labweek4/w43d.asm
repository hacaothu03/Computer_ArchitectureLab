.text 
li $s1, 10 #s1 =10
li $s2, 20 #s2 = 20
start:
sle $t0, $s1, $s2 # so sanh s1 <= s2 hay khong, roi cho ket qua vao t0
bne $t0, $zero, else # neu t0 khac 0 nhay den else
j endif	# neu t0 = 0 thuc hien j
else:
endif: