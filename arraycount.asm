 .data
welcome: .asciiz "\nWelcome to this program. This program implements the following problem: Count the number of multiples of X in a given array of 8 non-negative numbers, where X is a user chosen power-of-two value, e.g. 1, 2, 4, 8, ...."
# arrayA: .word 32, 16, 30, 23, 36, 18, 6, 48   # arrayA has 8 values
arrayA: .word 11, 0, 31, 22, 9, 17, 6, 9
count:  .word 0
prompt: .asciiz "\nPlease enter an integer X (a power of 2) = "
str: .asciiz "\nYou keyed in X = "
str2: .asciiz "\nFirst integer in array A: "
str3: .asciiz "\nLast integer in array A: "
str4: .asciiz "\nLoop through integers: "
str5: .asciiz "\nFinished looping through integers. \n"
spacing: .asciiz "; "
modulo: .asciiz " Modulo: "
not_multiple: .asciiz " (Not a multiple)"
multiple: .asciiz " (Is a multiple)"
going_to_print_count: .asciiz "\nHere's the count of multiples: "

  .text

main:
    li $v0, 4
    la $a0, welcome
    syscall

    # Map base address of arrayA to $s0.
    la $s0, arrayA

    # Map address of count to $s1.
    la $s1, count

    # Create a 'count' register in $s4
    add $s4, $zero, $zero

    # Display prompt to user.
    li $v0, 4
    la $a0, prompt
    syscall

    # Read in the user-specified value X into $s2.
    li $v0, 5
    syscall
    move $s2, $v0

    # Store the value of X-1 in $s3
    add $s3, $s2, -1

    # Readback of user value X
    li $v0, 4
    la $a0, str
    syscall
    li $v0, 1
    move $a0, $s2
    syscall

    # Tell user that we are going to read-back first integer.
    li $v0, 4
    la $a0, str2
    syscall

    # Display first element in the array
    lw $a0, 0($s0)
    li $v0, 1
    syscall

    # Tell user that we are going to read-back last integer.
    li $v0, 4
    la $a0, str3
    syscall

    # Display last integer in array. 
    lw $a0, -4($s1)
    li $v0, 1
    syscall

    # Tell user that we are going to loop through integers.
    li $v0, 4
    la $a0, str4
    syscall

    # Loop through integers. Use temp registers $t0 and $t4.

    move $t0, $s0
    loop: beq $t0, $s1, exitloop
          li $v0, 1
          lw $t4, 0($t0)
          add $a0, $zero, $t4
          syscall

          # Check if the integer is multiple of X
          and $t5, $t4, $s3

          beq $t5, $zero, IsMultiple

          IsNotMultiple:    li $v0, 4
                            la $a0, not_multiple
                            syscall
                            j RestOfLoop

          IsMultiple:       li $v0, 4
                            la $a0, multiple
                            syscall
                            addi $s4, $s4, 1

          RestOfLoop:       li $v0, 4
                            la $a0, spacing
                            syscall

                            addi $t0, $t0, 4
                            j loop
  
    exitloop:   li $v0, 4
                la $a0, str5
                syscall

    # tell user we are going to print count
    li $v0, 4
    la $a0, going_to_print_count
    syscall

    # print count
    li $v0, 1
    move $a0, $s4
    syscall

    # store count
    sw $s4, 0($s1)

    # as a check, try loading count value from address ( can also check data segment )
    lw $s5, 0($s1)

    # code for terminating program
    li  $v0, 10
    syscall
