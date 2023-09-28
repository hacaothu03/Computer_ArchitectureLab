.data
test: .ascii "Hello world"	#test: "Hello world"
.text
li $v0, 4			#v0=4: in chuoi
la $a0, test			#a0 lay dia chi cua chuoi
syscall				#in ra man hinh chuoi test