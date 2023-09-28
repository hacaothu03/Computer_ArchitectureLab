la	$s3, 0x10010004	
li	$s0, 0x1234abcd
sw	$s0, 0($s3)
sb	$s0, 5($s3)
sh	$s0, 10($s3)
lb	$t0, 0($s3)
lbu	$t1, 0($s3)
lh	$t2, 0($s3)
lhu	$t3, 0($s3)
lb	$t4, 1($s3)
lbu	$t5, 1($s3)
lh	$t6, 2($s3)
lhu	$t7, 2($s3)
#xác định nội dung các thanh ghi từ $t0 đến $t7 sau khi thực hiện đoạn chương trình trên