.data
test: .ascii "The sum of 5 and 4 is "
.text
li $v0,56
la $a0,test
li $a1,9
syscall