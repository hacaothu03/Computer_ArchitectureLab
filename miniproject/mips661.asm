addi $s1, $zero, 1
addi $s0, $zero, 1
lui $s2, 0x0000     # $s0 = 0x2
ori $s2, $s2, 0xf000    # $s0 = 0x23b8f000

loop:
    slti $t0, $s0, 10     # $t0 = (i < 10)
    beqz $t0, exit        # Nếu i >= 10, thoát khỏi vòng lặp

    sll $t1, $s0, 2       # $t1 = i * 4 (tính địa chỉ của phần tử M[i])
    addu $t2, $s2, $t1    # $t2 = địa chỉ cơ sở + (i * 4)

    lw $t4, 0($t2)
    addu $t3, $s1, $s0    # $t3 = a + i
    sw $t3, 0($t3)        # Gán giá trị t3 vào địa chỉ được lưu trong $t2

    addi $s0, $s0, 1     # i += 1
    j loop               # Quay lại vòng lặp

exit:
