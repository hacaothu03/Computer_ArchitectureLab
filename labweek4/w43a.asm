.text 
li $s1, 10 #s1 = 10
start: 
slt $t0, $s1, $zero #kiem tra s1 voi 0 cho ket qua vao thanh ghi t0
bne $t0, $zero, else #Neu t0 bang 0 thi thuc hien lenh tiep theo, neu khac 0 thi thuc hien lenh else
add $s0, $s1, $zero #neu s1>0 thi s0=s1
j endif
else:
sub $s0, $zero, $s1 #neu s1<0 thi s0 = -s1
endif: