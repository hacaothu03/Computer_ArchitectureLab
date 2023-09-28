lui $s6, 0x1010
ori $s6, $0, 0x1234
lui $s0, 0x1B32
ori $s0, $s0, 0xC2E5
sw $s0, 0($s6)
lb $s1, 1($s6)
