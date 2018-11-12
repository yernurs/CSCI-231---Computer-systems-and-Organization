.data
	input: .asciiz "Input your degree: "
	output: .asciiz "The sin of your degree is: " 
	pi: .double 3.142
	piDeg: .double 180.000
	zero: .double 0
	one: .double 1
	minus: .double -1
.text
main:
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 7
	syscall
	j my_sin
my_sin:
	jal rad
	li $t0,1 #$t0 is i
	li $t1,8
	l.d $f8,minus
	loop1:
		mul $t2, $t0,2 
		addi $t2,$t2,1 #$t3 is power
		move $a0,$t2
		jal fact
		mul.d $f2, $f2, $f8
		mul.d $f2, $f2, $f6
		mul.d $f2, $f2, $f6
		div.d $f2,$f2,$f4
		add.d $f0,$f0,$f2
		addi $t0,$t0,1
		bne $t0,$t1,loop1
	j Exit
rad:
	ldc1 $f28,pi
	ldc1 $f30,piDeg
	div.d $f0,$f0,$f30
	mul.d $f0,$f0,$f28 
	add.d $f2,$f2,$f0
	add.d $f6,$f6,$f0
	jr $ra
fact:
	#$a0 is N for factorial
	l.d $f4, one #$f2 contain N!
	li $a1,1
	addi $a0,$a0,1
	floop:
		mtc1.d $a1, $f26
  		cvt.d.w $f26, $f26	
		mul.d $f4, $f4, $f26
		addi $a1, $a1, 1
		bne $a0,$a1, floop
	jr $ra
	
Exit:
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0,3
	l.d $f12,zero
	add.d $f12,$f0,$f12
	syscall
	
	li      $v0, 10		#terminating
	syscall
