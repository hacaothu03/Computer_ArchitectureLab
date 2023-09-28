.data
name: .space 100
message: .asciiz "Input a name:"
new_name: .space 100
.text
input_name: 
	nop
	li $v0, 54
	la $a0, message
	la $a1, name
	la $a2, 100
	syscall
	j start
	
check_space:
	li $t9, 32
	beq $t2, $t9, space #if $t2 == 32 then go to space
	li $t0, 0
	
	jr $ra
	
space:
	li $t0, 1
	
	jr $ra
	
check_end:
	li $t8, 10
	beq $t2, $t8, end #if $t2 == 10 then go to end
	li $t4, 0
	
	jr $ra
	
end:
	li $t4, 1
	
	jr $ra
		
start:
	la $t1, name
	j loop
	
save_space_address:
	move $t3, $t1
	jal check_end
	bne $t4, $zero, copy_last_name
	addi $t1, $t1, 1
	
loop:
	lb $t2, 0($t1)
	jal check_space
	bne $t0, $zero, save_space_address
	jal check_end
	bne $t4, $zero, copy_last_name
	addi $t1, $t1, 1
	j loop
	
loop_copy_last_name:
	lb $t2, 1($t6)
	jal check_end
	bne $t4, $zero, copy_first_name
	sb $t2, 0($t5)
	addi $t6, $t6, 1
	addi $t5, $t5, 1
	j loop_copy_last_name
	
copy_last_name:
	la $t5, new_name
	move $t6, $t3
	j loop_copy_last_name
	
copy_first_name:
	li $t2, 32
	sb $t2, 0($t5)
	la $t1, name
	j loop_copy_first_name
	
loop_copy_first_name:
	lb $t2, 0($t1)
	sb $t2, 1($t5)
	addi $t1, $t1, 1
	addi $t5, $t5, 1
	beq $t1, $t3, print_result
	j loop_copy_first_name
	
print_result:
	li $v0, 4
	la $a0, new_name
	syscall