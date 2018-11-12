.data 
	DISPLAY: .space 16384  
	DISPLAYWIDTH: .word 64 
	DISPLAYHEIGHT: .word 64 
	radius: .double 15.00 
	X: .double -15.00
	one: .double 1
	inc: .double 0.125
	minus: .double -1
	COLOR: .word 0xC0392B 0xF39C12 0xF7DC6F 0x2ECC71 0x27AE60 0x2E86C1 0x8E44AD
.text 
main:
	#$f10 radius in doubles
	#f12 is X in doubles
	li $t9,0
	l.d $f10, radius
	l.d $f12, X
  	Loop:
  		l.d $f16, inc
  		add.d $f8,$f10,$f16
  		c.eq.d $f12,$f8
  		bc1t exitLoop
		
		mul.d $f0,$f10,$f10
		mul.d $f2,$f12,$f12
		sub.d $f4,$f0,$f2
		
		jal SQRT
		jal drawRainbow

		add.d $f12,$f12,$f16 #increment 
		j Loop
		exitLoop:							
			l.d $f18,minus
			add.d $f10,$f10,$f18
			mul.d $f12,$f10,$f18
			addi $t2,$t2,4
			addi $t9, $t9, 1
			beq $t9,8,exit 
			j Loop

exit:
	li $v0, 10
	syscall


#$t4 is Y as integer
#$t3 is X as integer
#$t2 is bytes where colors are stored
drawRainbow: 
		lw  $a2, COLOR($t2) #$t2 will change color 
		cvt.w.d $f14,$f12
		mfc1 $t3,$f14
		addi $a0,$t3,32 
		li  $t5, 32
		sub $a1,$t5, $t4
		move $t5,$ra
		jal set_pixel_color	
		jr $t5
#will take sqrt of #f2 and put in integer representation in $t4, which is Y		
SQRT:
	sqrt.d  $f2,$f4
	cvt.w.d $f2,$f2
	mfc1 $t4,$f2 
	jr $ra
	
	
set_pixel_color: 
# Assume a display of width DISPLAYWIDTH and height DISPLAYHEIGHT 
# Pixels are numbered from 0,0 at the top left 
# a0: x-coordinate 
# a1: y-coordinate 
# a2: color 
# address of pixel = DISPLAY + (y*DISPLAYWIDTH + x)*4 
# y rows down and x pixels across 
# write color (a2) at arrayposition 

	lw $t0, DISPLAYWIDTH 
	mul $t0, $t0, $a1 # y*DISPLAYWIDTH 
	add $t0,$t0, $a0 # +x 
	sll $t0, $t0, 2 # *4 
	la $t1, DISPLAY # get address of display: DISPLAY 
	add $t1, $t1, $t0 # add the calculated address of the pixel 
	sw $a2, ($t1) # write color to that pixel 
	jr $ra # return 

	



