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
	
	
	
	
	