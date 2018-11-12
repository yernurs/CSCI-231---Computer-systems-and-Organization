.data
	array:	.space 1024
	arrSize:	.word 1024
	repCount:	.word 4
	loopSize:	.word 1024 #CODE WORK FOR ANY NUMBER when !!!!!!!loopSize>=stepSize!!!!!!!!!
	stepSize:	.word 2 #CHANGE AND SEE IT
.text
main:
	lw 	$a0, arrSize
	lw 	$a1, loopSize
	lw 	$a2, repCount
	lw 	$a3, stepSize
	div 	$t1, $a0, $a1
	la 	$t9, array
	loop1:
		beq 	$t0,$t1,exit #t0 is index
		
		
		li $t2, 0		#t2 is repIdx
		loop2:
			beq 	$t2, $a2, skipLoop2	
			li 	$t3, 0	#t3 is loopIdx
			move 	$t6, $t9	#in order to 4 times add each byte,
					#we should preserve previous adress
					#and each time go through loop3
			loop3:
				beq 	$t3, $a1, skipLoop3
				li 	$t7, 0
				loop4:
					beq 	$t7, $a3, skipLoop4#loop will exit 
							        #when $t7==stepSize
					lb 	$t8, ($t9) #$t8 contain byte
					addi 	$t8, $t8, 1# we add 1 to byte
					sb	$t8, ($t9)	#store it
					addi 	$t9, $t9, 1#adress+1
					addi	$t7, $t7, 1
					j	 loop4
				skipLoop4:
				add	$t3, $t3, $a3
				j	loop3
			skipLoop3:	
			addi 	$t2, $t2, 1
			move 	$t9, $t6
			j 	loop2
		skipLoop2:	
		addi 	$t0, $t0, 1
		add  	$t9, $t9, $a1	
		j 	loop1
exit:
	li 	$v0, 10
	syscall
