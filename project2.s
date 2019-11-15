#HU ID: @02884990
#02884990%11 = 9
#26 + 9 = Base 35
#Range (0,y) and (0-Y)

.data 						#Declarations
InputVariable: .space 1000			#Variable for user input 
list: .word 0,0,0,0				#Created a word list
BadInput: .asciiz "Invalid input"		#Variable used to output Invalid input

.text						#Instructions stored in text segment at next available address
.globl main					#Allows main to be refrenced anywhere


main:
	li $v0, 8				#Allows user to input
	la $a0, InputVariable			#Saves input to  variable
	li $a1, 1001				#Allows the input to be 1000 characters
	syscall 				#Issues a System Call
	
	la $t1,InputVariable			#Load the variable to the register $t1
	li $t2,4				#Stored to check if variable is greater than 4
	li $t3,32				#Stored a space in $t3 to check for spaces
	li $t4,9				#Stored to check for tabs
	li $t5,0				#Variable for total valid characters
	li $t0,0				#Variable initialized to 0
	li $s0,48				#For lowest valid non letter input option
	li $s1,57				#For highest valid non letter input option
	li $s2,65				#For lowest capital letter
	li $s3,89				#For highest capital letter (I go to Y not Z)
	li $s4,97				#For lowest common letter
	li $s5,121				#For highest common letter (I go to y not z)
	li $t7,0				#Initialized for sum
	la $s6, list				#Stores the list in a variable
	li $s7, 0x0A				#Stored a new line
	
	
	
	loop:
		bgt $t5,$t2, output_bad_input		#Branch if more than 4 good characters
		lb $t6,0($t1)				#Gets each integer from the input
		beq $t5,$t0, beginning_characters	#Branch as long as no valid characters have been found
		beq $t6,$t3, ending_characters		#Branch if trailing character is a space
		beq $t6,$t4, ending_characters		#Branch if trailing characters is a tab
		beq $t6,$s7, good_input			#Branch if new line comes before a bad input
		j check_character			#Jump to check character function if it doesnt branch
	
	output_bad_input:			#Fucntion to print invalid output
	li $v0,4
	la $a0, BadInput			#Prints Invalid input
	syscall					#Issues a System Call
	
	li $v0, 10				#End of program if this is reached
	syscall					#Issues a System Call
	
	
	beginning_characters:			#Function that checks if character is a space or tab
	beq $t6,$t3, skip_character		#Branches if character is a space
	beq $t6,$t4, skip_character		#Branches if character is a tab
	j check_character			#Jump to check_character
	
	
	skip_character:				#Function that moves to next character
	addi $t1,$t1, 1				#Increments $t1 to check next number
	j loop					#Jumps back to beginning of loop
	
	
	check_character:			#Function to see if character is invalid
	blt $t6,$s0, output_bad_input		#Branch if character is below ASCII number for 0
	bgt $t6,$s1, check_capital		#Branch if character is above ASCII number for 9
	addi $t6,$t6, -48			#Convert it to its decimal counterpart
	j incrementor				#Jump to incrementor function
	
	
	check_capital:				#Function that checks if input is valid when above numbers
	blt $t6,$s2, output_bad_input		#Branch if character is less than $s2
	bgt $t6,$s3, check_common		#Branch if character is greater than $s3
	addi $t6,$t6, -55			#Convert it to its decimal counterpart
	j incrementor				#Jump to incrementor function
	

	check_common:				#Function that checks if input is valid when above capital letters
	blt $t6,$s4, output_bad_input		#Branch if character is less than $s4
	bgt $t6,$s5, output_bad_input		#Branch if character is gretaer than $s5
	addi $t6,$t6, -87			#Convert it to its decimal counterpart
	j incrementor				#Jump to incrementor function
	
	
	incrementor:				#Function to increment all variables
	sb $t6, 0($s6)		 		#Stores the character in a string
	addi $s6,$s6, 1 			#Increment array posistion
	addi $t1,$t1, 1 			#Increment the input string
	addi $t5,$t5, 1 			#Increment the number of valid characters
	j loop					#Go back to loop
	
	
	ending_characters:			#Function to check for trailing spaces and tabs
	addi $t1,$t1, 1 			#Goes to next byte
	lb $t6, 0($t1)  			#Gets a characher of string
	beq $t6,$t3, good_input			#Branches if trailing character is a space
	bne $t6,$t3, tab_checker		#Branches if not equal to a space
	j ending_characters			#Jumps back to check next posistion
	
	
	tab_checker:				#Function to see if character is equal to a tab
	bne $t6,$t4, output_bad_input 		#Branches if not equal to a tab
	j ending_characters			#Jumps to ending character to check nexrt posisition
	
	
	good_input:				#Function to send good inputs to the subprogram
	li $a0, 35 				#initialized the base to 35
	jal subprogram				#Subprogram to do calculations
	add $a1,$zero,$s6			
	sub $a1,$a1,$t5				
	li $v0, 10				#End of file
	syscall					#System Call
	
			
	subprogram:				#Subprogram to do calculations
	li $s0, 1				#Reinitialized to store 1
	li $s1, 2				#Reinitialized to store 2
	li $s2, 3				#Reinitialized to store 3
	li $s3, 4				#Reinitialized to store 4
	
	jr $ra
	