.data
student1:   .space 50       # Allocate memory for student 1's name
student2:   .space 50       # Allocate memory for student 2's name
message:    .asciiz "Converted names:\n"

.text
main:
    # Input names
    li $v0, 8                  # System call code for reading string
    la $a0, student1           # Load address of student1 string
    li $a1, 50                 # Maximum length of the string
    syscall                    # Read student1 name

    li $v0, 8                  # System call code for reading string
    la $a0, student2           # Load address of student2 string
    li $a1, 50                 # Maximum length of the string
    syscall                    # Read student2 name

    # Convert names
    jal convertName            # Jump to the convertName subroutine

    # Print names using a message dialog
    li $v0, 59                 # System call code for message dialog
    la $a0, message            # Load address of the message
    la $a1, student1           # Load address of student1 string
    syscall                    # Print student1 name in the message dialog

    li $v0, 59                 # System call code for message dialog
    la $a0, message            # Load address of the message
    la $a1, student2           # Load address of student2 string
    syscall                    # Print student2 name in the message dialog

    # Exit program
    li $v0, 10                 # System call code for exit
    syscall

# Subroutine to convert name from LastName-FirstName to FirstName-LastName
convertName:
    la $t0, student1           # Load address of student1 string
    la $t1, student2           # Load address of student2 string

    # Convert student1 name
    convert_student1:
        lbu $t2, 0($t0)        # Load a character from student1 string
        beqz $t2, convert_student2  # Branch if end of string is reached
        addiu $t0, $t0, 1      # Increment address of student1 string

        lbu $t3, 0($t0)        # Load next character from student1 string
        beqz $t3, convert_student2  # Branch if end of string is reached

        # Check if space is encountered
        beq $t3, 32, convert_student1  # Branch if space is encountered

        sb $t3, 0($t1)         # Store character in student2 string
        addiu $t1, $t1, 1     # Increment address of student2 string
        j convert_student1    # Jump back to convert_student1

    # Convert student2 name
    convert_student2:
        lbu $t2, 0($t0)        # Load a character from student1 string
        beqz $t2, end_convert  # Branch if end of string is reached
        addiu $t0, $t0, 1      # Increment address of student1 string

        lbu $t3, 0($t0)        # Load next character from student1 string
        beqz $t3, end_convert  # Branch if end of string is reached

        # Check if space is encountered
        beq $t3, 32, convert_student2  # Branch if space is encountered

        sb $t3, 0($t1)         # Store character in student2 string
        addiu $t1, $t1, 1     # Increment address of student2 string
        j convert_student2    # Jump back to convert_student2

    end_convert:
        sb $zero, 0($t1)      # Null-terminate student2 string
        jr $ra                 # Return from subroutine
