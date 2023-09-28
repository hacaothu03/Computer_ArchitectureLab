.data
x: .space 20
string: .space 20
Message1: .asciiz "Input a string "
Message2: .asciiz "Reverse string "
.text
main:
get_string:
li $v0,8
la $a0, string
la $a1, 21
syscall
get_length: 
la $a0, string
xor $v0, $zero, $zero
xor $t0, $zero, $zero
check_char: 
add $t1, $a0, $t0
lb $t2, 0($t1)
beq $t2, $zero, end_of_str
addi $v0, $v0, 1
addi $t0, $t0, 1
j check_char
end_of_str:
end_of_get_length:
addi $t0, $v0, -1
move $s0, $a0
print_reverse:
li $v0,11
add $t1, $s0, $t0
lb $a0,0($t1)
syscall
addi $t0,$t0,-1
blt $t0, $zero, done2
j print_reverse
done2:
