#Laboratory Exercise 3, Assignment 6
.data
A: .word 1, 2, 3, 4, 3, 0
.text
	li $s4 1 #step = 1
	li $s3 6 #n = 6
	la $s2, A 
	lw $s6, 0($s2) #max = A[0]
loop: 
 add $t1,$t1,$s2  #t1 store the address of A[i] 
 lw $t0,0($t1)  #load value of A[i] in $t0 
 add $s5,$s5,$t0  #sum=sum+A[i] 
 add $s1,$s1,$s4  #i=i+step 
 add $t1,$s1,$s1  #t1=2*s1 
 add $t1,$t1,$t1  #t1=4*s1  
 slt $t3, $s6, $t0 #max<A[i] 
 bne $t3, $zero, max #if max<A[i], max = A[i]
 bne $s1,$s3,loop #if i!=n, goto loop  
 j else
max:
 add $s6, $zero, $t0
 bne $s1,$s3,loop #if i!=n, goto loop  
else: