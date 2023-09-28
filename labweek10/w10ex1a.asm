# Định nghĩa hằng số địa chỉ của đèn LED 7 đoạn trái
.eqv SEVENSEG_LEFT    0xFFFF0011 # Địa chỉ của đèn LED 7 đoạn trái. 
                                 # Bit 0 = đoạn a;  
                                 # Bit 1 = đoạn b; ...  
                                 # Bit 7 = dấu . 

.data
A: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F  # Giá trị hiển thị cho các số từ 0 đến 9

.text 
main:
    li $s1, 0       # Khởi tạo giá trị ban đầu của biến đếm i = 0
    la $s0, A       # Lấy địa chỉ của mảng A vào thanh ghi s0
    li $s3, 10      # Lưu giá trị 10 vào thanh ghi s3
    addi $v0, $0, 32
    li $a0, 1000
    syscall

loop:
    sll $s5, $s1, 2 # Địa chỉ offset = i * 4 (do từng phần tử trong mảng có kích thước 4 byte)
    add $s6, $s0, $s5 # Địa chỉ của phần tử hiện tại trong mảng
    lw $a0, 0($s6)  # Lấy giá trị hiển thị từ mảng
    jal SHOW_7SEG_LEFT # Hiển thị giá trị
    nop
    beq $s1, $s3, main  # Nếu i = 10, quay lại main
    addi $s1, $s1, 1  # Tăng biến đếm i lên 1

sleep:
    addi $v0, $0, 32
    li $a0, 1000
    syscall
    j loop  # Quay lại vòng lặp loop

exit:
    li $v0, 10 
    syscall 

endmain: 

SHOW_7SEG_LEFT:
    li $t0, SEVENSEG_LEFT # Gán địa chỉ cổng vào thanh ghi t0
    sb $a0, 0($t0) # Gán giá trị mới
    nop
    jr $ra  # Trở lại địa chỉ trả về
    nop
