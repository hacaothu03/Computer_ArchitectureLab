.data
A: .word 0,0,10,-2,4,5,1,2,3,-10,12	#khai bao mang A
message: .asciiz "  "

.text
	la $s0,A
	li $t0,10
	li $t1,0
for1:
	slt $t7,$t1,$t0
	beq $t7,$zero,end_for1
	li $t2,0
	sub $t3,$t0,$t1
for2:
	slt $t7,$t2,$t3
	beq $t7,$zero,end_for2
	sll $t4,$t2,2
	add $t5,$t4,$s0
	lw $t6,0($t5)
	lw $s6,4($t5)
	slt $s5,$s6,$t6
	bne $s5,$zero,swap
j next
swap:
	sw $t6,4($t5)
	sw $s6,0($t5)
next:
	addi $t2,$t2,1
j for2
end_for2:
	addi $t1,$t1,1
j for1
end_for1:
	la $s0,A
	li $s1,11
	li $s2,0
loop:
	slt $s3,$s2,$s1
	beq $s3,$zero,end_loop
	sll $s4,$s2,2
	add $s5,$s0,$s4
	lw $s6,0($s5)
	li $v0,1
	move $a0,$s6
	syscall
	li $v0,4
	la $a0,message
	syscall
	addi $s2,$s2,1
	j loop
end_loop:
	