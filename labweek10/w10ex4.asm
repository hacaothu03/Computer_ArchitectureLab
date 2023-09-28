.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
# Auto clear after sw
.data
key: .space 5
string: .space 10
.text
li $k0, KEY_CODE
li $k1, KEY_READY
li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY
la $a0, string
main:
char1:
jal loop
beq $t0, 101, char2
j char1

char2:
jal loop
beq $t0, 120, char3
beq $t0, 101, char2
j char1

char3:
jal loop
beq $t0, 105, char4
beq $t0, 101, char2
j char1

char4:
jal loop
beq $t0, 116, end_main
beq $t0, 101, char2
j char1
end_main:
exit:
li $v0, 10
syscall
loop: 
nop
WaitForKey: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
nop
beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
nop
#-----------------------------------------------------
ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
nop
#-----------------------------------------------------
WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
nop
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
nop
#-----------------------------------------------------
ShowKey:
sw $t0, 0($s0)
nop 
jr $ra
