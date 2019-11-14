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
	
	
	loop:
		bgt $t5, $t2, output_bad_input		#Branch if more than 4 good characters
		lb $t6, 0($t1)				#Gets each integer from the input
		beq $t5, $t0, beginning characters	#Branch as long as no valid characters have been found
		
	
	output_bad_input:
	li $v0,4
	la $a0, BadInput			#Prints Invalid input
	syscall
	
	li $v0, 10				#End of program if this is reached
	syscall					
	
	
