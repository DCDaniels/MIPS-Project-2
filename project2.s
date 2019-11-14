#HU ID: @02884990
#02884990%11 = 9
#26 + 9 = Base 35
#Range (0,y) and (0-Y)

.data 						#Declarations
InputVariable: .space 1000			#Variable for user input 
BadInput: .asciiz "Invalid input"		#Variable used to output Invalid input
.text						#Instructions stored in text segment at next available address
.globl main					#Allows main to be refrenced anywhere


main:
	li $v0, 8				#Allows user to input
	la $a0, InputVariable			#Saves input to  variable
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
	
	
	loop:
		bgt $t5, $t2, output_bad_input		#Branch if more than 4 good characters
		lb $t6, 0($t1)				#Gets each integer from the input
		beq $t5, $t0, beginning_characters	#Branch as long as no valid characters have been found
		
	
	
	output_bad_input:			#Fucntion to print invalid output
	li $v0,4
	la $a0, BadInput			#Prints Invalid input
	syscall					#Issues a System Call
	
	li $v0, 10				#End of program if this is reached
	syscall					#Issues a System Call
	
	
	beginning_characters:			#Function that checks if character is a space or tab
	beq $t6, $t3, skip_character		#Branches if character is a space
	beq $t6, $t4, skip_character		#Branches if character is a tab
	j check_character			#Jump to check_character
	
	
	skip_character:				#Function that moves to next character
	addi $t1,$t1,1				#Increments $t1 to check next number
	j loop					#Jumps back to beginning of loop
	
	
	check_character:			#Function to see if character is invalid
	blt $t6, $s0, output_bad_input		#Branch if character is below ASCII number for 0
	bgt $t6, $s1, check_capital		#Branch if character is above ASCII number for 9
	addi $t6, $t6, -48			#Convert it to its decimal counterpart
	
	
	check_capital:				#Function that checks if input is valid when above numbers
	blt $t6,$s2, output_bad_input		#Branch if character is less than $s2
	bgt $t6,$s3, check_common		#Branch if character is greater than $s3
	addi $t6, $t6, -55			#Convert it to its decimal counterpart

	check_common:				#Function that checks if input is valid when above capital letters
	blt $t6, $s4, output_bad_input		#Branch if character is less than $s4
	bgt $t6, $s5, output_bad_input		#Branch if character is gretaer than $s5
	addi $t6, $t6, -87			#Convert it to its decimal counterpart
	
	