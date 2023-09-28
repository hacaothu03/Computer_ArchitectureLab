.data
name1: .space 100                    # Vùng nhớ để lưu trữ tên thứ nhất
name2: .space 100                    # Vùng nhớ để lưu trữ tên thứ hai
message1: .asciiz "Input name 1: "   # Chuỗi thông báo yêu cầu nhập tên thứ nhất
message2: .asciiz "Input name 2: "   # Chuỗi thông báo yêu cầu nhập tên thứ hai
new_name1: .space 100                 # Vùng nhớ để lưu trữ tên mới 1
new_name2: .space 100                 # Vùng nhớ để lưu trữ tên mới 2

.text
input_names:
    nop
    li $v0, 54                        # Chuẩn bị syscall để nhập chuỗi

    # Input name 1
    la $a0, message1                  # In thông báo yêu cầu nhập tên thứ nhất
    la $a1, name1                     # Địa chỉ của name1
    la $a2, 100                       # Độ dài tối đa của chuỗi nhập vào
    syscall

    # Input name 2
    la $a0, message2                  # In thông báo yêu cầu nhập tên thứ hai
    la $a1, name2                     # Địa chỉ của name2
    la $a2, 100                       # Độ dài tối đa của chuỗi nhập vào
    syscall

    j process_names                   # Chuyển đến quá trình xử lý tên

check_space:
    li $t9, 32                        # ASCII của dấu cách (space)
    beq $t2, $t9, space               # Nếu ký tự hiện tại là dấu cách, chuyển đến space
    li $t0, 0                         # Không phải dấu cách, gán giá trị 0 cho $t0
    jr $ra                            # Trở về lệnh gọi

space:
    li $t0, 1                         # Đã gặp dấu cách, gán giá trị 1 cho $t0
    jr $ra                            # Trở về lệnh gọi

check_end:
    li $t8, 10                        # ASCII của ký tự xuống dòng (newline)
    beq $t2, $t8, end                 # Nếu ký tự hiện tại là xuống dòng, chuyển đến end
    li $t4, 0                         # Không phải xuống dòng, gán giá trị 0 cho $t4
    jr $ra                            # Trở về lệnh gọi

end:
    li $t4, 1                         # Đã gặp xuống dòng, gán giá trị 1 cho $t4
    jr $ra                            # Trở về lệnh gọi

process_names:
    # Process name 1
    la $t1, name1                     # Địa chỉ của name1
    la $t5, new_name1                 # Địa chỉ của new_name1
    j loop                            # Bắt đầu vòng lặp

save_space_address1:
    move $t3, $t1                     # Lưu địa chỉ của space vào $t3
    jal check_end                     # Kiểm tra xem có gặp ký tự xuống dòng hay không
    bne $t4, $zero, copy_last_name1   # Nếu có, chuyển đến copy_last_name1
    addi $t1, $t1, 1                  # Tăng địa chỉ lên 1 để bỏ qua dấu cách
    j loop                            # Tiếp tục vòng lặp

loop:
    lb $t2, 0($t1)                    # Load ký tự hiện tại vào $t2
    jal check_space                   # Kiểm tra xem có gặp dấu cách hay không
    bne $t0, $zero, save_space_address1 # Nếu có, chuyển đến save_space_address1
    jal check_end                     # Kiểm tra xem có gặp ký tự xuống dòng hay không
    bne $t4, $zero, copy_last_name1   # Nếu có, chuyển đến copy_last_name1
    addi $t1, $t1, 1                  # Tăng địa chỉ lên 1 để di chuyển đến ký tự tiếp theo
    j loop                            # Tiếp tục vòng lặp

copy_last_name1:
    la $t5, new_name1                 # Địa chỉ của new_name1
    move $t6, $t3                     # Địa chỉ của space
    j loop_copy_last_name1            # Bắt đầu vòng lặp copy_last_name1

loop_copy_last_name1:
    lb $t2, 1($t6)                    # Load ký tự tiếp theo vào $t2
    jal check_end                     # Kiểm tra xem có gặp ký tự xuống dòng hay không
    bne $t4, $zero, copy_first_name1  # Nếu có, chuyển đến copy_first_name1
    sb $t2, 0($t5)                    # Sao chép ký tự vào vị trí thích hợp trong new_name1
    addi $t6, $t6, 1                  # Tăng địa chỉ lên 1 để di chuyển đến ký tự tiếp theo
    addi $t5, $t5, 1                  # Tăng địa chỉ lên 1 để di chuyển đến vị trí tiếp theo trong new_name1
    j loop_copy_last_name1            # Tiếp tục vòng lặp copy_last_name1

copy_first_name1:
    li $t2, 32                        # ASCII của dấu cách (space)
    sb $t2, 0($t5)                    # Sao chép dấu cách vào vị trí thích hợp trong new_name1
    la $t1, name1                     # Địa chỉ của name1
    j loop_copy_first_name1           # Bắt đầu vòng lặp copy_first_name1

loop_copy_first_name1:
    lb $t2, 0($t1)                    # Load ký tự tiếp theo vào $t2
    sb $t2, 1($t5)                    # Sao chép ký tự vào vị trí thích hợp trong new_name1
    addi $t1, $t1, 1                  # Tăng địa chỉ lên 1 để di chuyển đến ký tự tiếp theo trong name1
    addi $t5, $t5, 1                  # Tăng địa chỉ lên 1 để di chuyển đến vị trí tiếp theo trong new_name1
    beq $t1, $t3, process_name2       # Nếu đã sao chép hết name1, chuyển đến quá trình xử lý name2
    j loop_copy_first_name1           # Tiếp tục vòng lặp copy_first_name1

process_name2:
    # Process name 2
    la $t1, name2                     # Địa chỉ của name2
    la $t5, new_name2                 # Địa chỉ của new_name2
    j loop2                           # Bắt đầu vòng lặp

save_space_address2:
    move $t3, $t1                     # Lưu địa chỉ của space vào $t3
    jal check_end                     # Kiểm tra xem có gặp ký tự xuống dòng hay không
    bne $t4, $zero, copy_last_name2   # Nếu có, chuyển đến copy_last_name2
    addi $t1, $t1, 1                  # Tăng địa chỉ lên 1 để bỏ qua dấu cách
    j loop2                           # Tiếp tục vòng lặp

loop2:
    lb $t2, 0($t1)                    # Load ký tự hiện tại vào $t2
    jal check_space                   # Kiểm tra xem có gặp dấu cách hay không
    bne $t0, $zero, save_space_address2 # Nếu có, chuyển đến save_space_address2
    jal check_end                     # Kiểm tra xem có gặp ký tự xuống dòng hay không
    bne $t4, $zero, copy_last_name2   # Nếu có, chuyển đến copy_last_name2
    addi $t1, $t1, 1                  # Tăng địa chỉ lên 1 để di chuyển đến ký tự tiếp theo
    j loop2                           # Tiếp tục vòng lặp

copy_last_name2:
    la $t5, new_name2                 # Địa chỉ của new_name2
    move $t6, $t3                     # Địa chỉ của space
    j loop_copy_last_name2            # Bắt đầu vòng lặp copy_last_name2

loop_copy_last_name2:
    lb $t2, 1($t6)                    # Load ký tự tiếp theo vào $t2
    jal check_end                     # Kiểm tra xem có gặp ký tự xuống dòng hay không
    bne $t4, $zero, copy_first_name2  # Nếu có, chuyển đến copy_first_name2
    sb $t2, 0($t5)                    # Sao chép ký tự vào vị trí thích hợp trong new_name2
    addi $t6, $t6, 1                  # Tăng địa chỉ lên 1 để di chuyển đến ký tự tiếp theo
    addi $t5, $t5, 1                  # Tăng địa chỉ lên 1 để di chuyển đến vị trí tiếp theo trong new_name2
    j loop_copy_last_name2            # Tiếp tục vòng lặp copy_last_name2

copy_first_name2:
    li $t2, 32                        # ASCII của dấu cách (space)
    sb $t2, 0($t5)                    # Sao chép dấu cách vào vị trí thích hợp trong new_name2
    la $t1, name2                     # Địa chỉ của name2
    j loop_copy_first_name2           # Bắt đầu vòng lặp copy_first_name2

loop_copy_first_name2:
    lb $t2, 0($t1)                    # Load ký tự tiếp theo vào $t2
    sb $t2, 1($t5)                    # Sao chép ký tự vào vị trí thích hợp trong new_name2
    addi $t1, $t1, 1                  # Tăng địa chỉ lên 1 để di chuyển đến ký tự tiếp theo trong name2
    addi $t5, $t5, 1                  # Tăng địa chỉ lên 1 để di chuyển đến vị trí tiếp theo trong new_name2
    beq $t1, $t3, exit                # Nếu đã sao chép hết name2, chuyển đến exit
    j loop_copy_first_name2           # Tiếp tục vòng lặp copy_first_name2

exit:
    li $v0, 10                        # Chuẩn bị syscall để thoát chương trình
    syscall
