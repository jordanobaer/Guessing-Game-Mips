#Jordano Baer

.data
	hello_string: .asciiz "Welcome to the MIPS Guessing Game. Please Guess a number between 1 and 100"
	guess_string: .asciiz "My guess is: "
	end_string: .asciiz "Yay! I got it in: "
	end2_string: .asciiz " Tries!"
	
.text
	li $s0, 1	#lower 
	li $s1, 101	#upper
	li $s2, 'h'
	li $s3, 'l'
	li $s4, 'x'
	li $s5, 0 	#number of tries
	#s6 = random number
	#s7 = input
	
	la $a0, hello_string
	li $v0, 4
	syscall		#print hello string
	
	li $a0, 10		
	li $v0, 11		
	syscall		#print new line
	
	
loop:	la $a0, guess_string
	li $v0, 4
	syscall		#print my guess is
	
	jal calculate
	
	li $a0, 10		
	li $v0, 11		
	syscall		#print new line
	
	li $v0, 12	#read input
	syscall
	
	add $s7, $v0 ,$zero #s7 = input
	
	li $a0, 10		
	li $v0, 11		
	syscall		#print new line
	
	beq $s7, $s4, end #go to end if input is x
	beq $s7, $s2, increase
	j decrease
	
increase:
	add $s0,$s6,$zero	#increase the lower bound
	addi $s0, $s0, 1
	j loop

decrease:
	add $s1, $s6, $zero 	#decrease upper bound
	j loop
	
	
end:

	la $a0, end_string
	li $v0, 4
	syscall		#print end string
	
	add $a0, $s5, $zero
	li $v0, 1
	syscall		#print number of tries

	la $a0, end2_string
	li $v0, 4
	syscall		#print end string

	li $v0, 10		# EXIT
	syscall	

	
calculate:
	sub $t0, $s1,$s0	#subtract upper and lower bounds
	la $a1, ($t0) #upper bound of generated number
	li $v0, 42
	syscall
	add $a0, $a0, $s0 #add lower bound to random number
	add $s6, $a0, $zero #s6 = random number
	addi $s5, $s5, 1 #increment number of tries
	
	add $a0, $s6, $zero
	li $v0, 1   #print random
    	syscall
    	jr $ra
	
