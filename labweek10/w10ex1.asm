.eqv SEVENSEG_LEFT 0xFFFF0011 # Địa chỉ của đèn LED 7 đoạn trái.
# Bit 0 = đoạn a;
# Bit 1 = đoạn b; ...
# Bit 7 = dấu .

.data
digits: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F  # Giá trị hiển thị cho các số từ 0 đến 9

.text
main:
  li $t0, 0 # Khởi tạo giá trị ban đầu của biến đếm

  loop:
    lw $a0, digits($t0) # Lấy giá trị hiển thị từ mảng
    jal SHOW_7SEG_LEFT # Hiển thị giá trị
    nop

    # Độ trễ
    li $t1, 1000000 # Đặt giá trị độ trễ tùy ý
    delay_loop:
      addiu $t1, $t1, -1
      bne $t1, $zero, delay_loop

    addiu $t0, $t0, 1 # Tăng biến đếm lên 1
    bne $t0, 10, loop # Lặp lại nếu biến đếm chưa đạt giá trị 10
    li $t0, 0 # Đặt biến đếm về 0 nếu đã đạt giá trị 10

    # Độ trễ trước khi hiển thị số 0
    li $t1, 1000000 # Đặt giá trị độ trễ tùy ý
    delay_loop2:
      addiu $t1, $t1, -1
      bne $t1, $zero, delay_loop2

  exit:
    li $v0, 10
    syscall
endmain:

#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT: Bật/Tắt đèn LED 7 đoạn trái
# param[in] $a0: Giá trị để hiển thị
# Lưu ý: $t0 thay đổi
#---------------------------------------------------------------
SHOW_7SEG_LEFT:
  li $t0, SEVENSEG_LEFT # Gán địa chỉ cổng
  sb $a0, 0($t0) # Gán giá trị mới
  nop
  jr $ra
  nop
