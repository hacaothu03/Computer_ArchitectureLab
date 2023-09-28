#Laboratory 5a
.data
A: .word 1,2,3,4,5,6,7,8,9
.text
li $s1,-1 #i=-1
la $s2,A #s2 chua dia chi mang A
li $s3,9 #so phan tu mang A
li $s4,1 #step
li $s5,0 #khoi tao sum
loop: add $s1,$s1,$s4 #i=i+step
add $t1,$s1,$s1 #t1=2*s1
add $t1,$t1,$t1 #t1=4*s1
add $t1,$t1,$s2 #t1 store the address of A[i]
lw $t0,0($t1) #load value of A[i] in $t0
add $s5,$s5,$t0 #sum=sum+A[i]
bne $t0,$zero,loop #if true goto loop else exit