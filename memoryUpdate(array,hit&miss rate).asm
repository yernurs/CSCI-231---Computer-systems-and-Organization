.data
	array:	.space 1024
	
.text
#-----------------------------
#THIS CODE WILL WORK FOR ALL CASES, WHEN ARRAY IS EMPTY OR NOT
#IT WILL UPDATE EACH BYTE 
#it is stupid to write code only for empty case of array, so my Memory Acess counts not changing
#20480 metric score is best which can be reached with proper code



#Number of blocks: 1
#Cache block size: 32
# 2048(110-100)= my metric score
# METRIC SCORE: 20480 for bytes, halfs, words, doubles 
# The miss apears at the end of the blocks
# the fewer we have block
# then fewer we have miss count
# thats why optimization with Max size of block 
# improve the performance 
main:
	
	la	$a0, array
	li $s3, 123
	li $s2, 22
	sw $s3,array($s5)
	addi $s5,$s5,4
	sw $s2,array($s5)
	addi	$a1,$zero,1024	# 512 for halfs #256 for words #128 for doubles 
				#ArraySize
	addi	$a2,$zero,1		# 2   for halfs #4   for words #8   for doubles   
				#StepSize
	mul 	$t1,$a1,$a2	#1024 bytes = StepSize*ArrSize
	loop:
		beq 	$t0,$t1,exit
		add 	$t8,$t0,$a2 	# t8 hold next step
		add 	$t9,$t0,$zero	# t9 hold current step
		loop2:
			beq $t9,$t8,skip # when current=next
				   # it should exit loop2
			lb 	$t2, array($t9)# loading byte
			addi 	$t2,$t2,4	 # add 1 to byte
			sb 	$t2, array($t9)# store byte 
			addi 	$t9,$t9,1	 # next byte in current step
			j loop2
		skip:
		add 	$t0,$a2,$t0 #next step
		j loop	

exit:
	li $v0,10
	syscall 
