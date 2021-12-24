# messages.asm
  .data 
str: .asciiz "the answer = "
  .text

# i dont think this works.
#my first try.

main: 
    li   $v0, 5    # system call code for read_int
    syscall        # call read_int

    li   $v1, 4    # system call code for print_string
    la   $a0, str  #  load string
    syscall        # print string
    
    li   $v1, 1    # system call code for print_int
    add  $a0, $v0, $zero  # Load integer
    syscall        # print integer

    li   $v1, 10   # system call code for exit
    syscall        # terminate program
