#Laboratory Exercise 4d
.text
li $s1,5
li $s2,6
li $s3,10
li $s4,11
start:
add $s7,$2,$s1
add $s6,$s6,$s4
sle $t0,$s7,$s6 # j<i if s2<s1 t0=1
bne $t0,$zero,else # branch to else if j<i bne not equal to 0
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” part
else: addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif: