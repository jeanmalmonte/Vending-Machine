# Vending Machine 
# A Vending Machine that sells soft drinks.
# Jean Michael Almonte

.globl main

# Constant operands needed for the execution of the program
.data                        
# Prompts
welcome:        .asciiz "Welcome to Mr. Zippy's soft drink vending machine\n"
cost:           .asciiz "Cost of Coke, Sprite, Dr. Pepper, Diet Coke, and Mellow Yellow is 55 cents.\n"
enterPrompt:    .asciiz "Enter coin or select return.\n"
total:          .asciiz "Total is "
centsP:         .asciiz " cents.\n"
errorInput:     .asciiz "Please enter a valid choice\n"
change:         .asciiz "Your change is "
slugError:      .asciiz "Mr. Zippy is not amused... >:(\n"
makeSel:        .asciiz "Make selection or return: (C) Coke, (S) Sprite, (P) Dr. Pepper, (D) Diet Coke, or (M) Mellow Yellow\n"
sel:            .asciiz "Selection is "
amntReturned:   .asciiz "Your return amount is "
nodrink:        .asciiz "Out of "

# Drinks / Sodas
coke:           .asciiz "Coke\n"
sprite:         .asciiz "Sprite\n"
pepper:         .asciiz "Dr. Pepper\n"
dcoke:          .asciiz "Diet Coke\n"
myellow:        .asciiz "Mellow Yellow\n"

# Initial number of drinks in the machine available
cokeVar:       .word  10
spriteVar:     .word  10
pepperVar:     .word  10
dcokeVar:      .word  10
myellowVar:    .word  10

# Money
penny:      .word 1             
nickle:     .word 5             
dime:       .word 10             
quarter:    .word 25             
fifty:      .word 50               
dollar:     .word 100             
ffive:      .word 55           

# Formatting
space:      .asciiz " "
comma:      .asciiz ", "
newline:    .asciiz "\n"

.text 
main:

    # Initialize values
    lw $s1, ffive                   # load 55 into $s1 so we don't have to keep doing it in every loop iteration
    xor $s4, $s4, $s4               # clear the contents of the register $s4

    # Print soda machine prompt
    li $v0, 4                       # system call code for print_str
    la $a0, welcome                 # load address of welcome into $a0
    syscall                         # print the prompt

    la $a0, cost                    # load address of cost into $a0
    syscall                         # print the prompt

    promptUser:                       
        la $a0, enterPrompt         # load address of coin into $a0
        syscall                     # print the prompt
        li $v0, 12                  # read character from the console
        syscall                     # read the character into $v0
        move $s0, $v0               # save the value into $s0 

    parseInput: 
    #User enters penny -> P
    li $t0, 'P'                     # load "P" into $t0 to compare user input in $s0 
    li $t1, 'p'                     # load lowercase "p" into $t1 to compare to input in $s0
    
    beq $s0, $t0, userPenny         # branch if $s0 is equal to "P"
    beq $s0, $t1, userPenny         # branch if $s0 is equal to "p"
    j userPennyDone                 # if no branch jump to done, continue parsing

    userPenny:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        lw $s2, penny               # load penny word into $s2
        add $s4, $s4, $s2           # add it to running total 

        li $v0, 4                   # system call code for print_str
        la $a0, total               # load address of total to print to system
        syscall                     # print "Total is: "
        
        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # move $s4 into $a0 to print integer
        syscall                     # print the number

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall

        j parseInput_exit           # jump to done     
    userPennyDone:
    
    #user enters nickle -> N
    li $t0, 'N'                     # load "N" into $t0 to compare user input in $s0
    li $t1, 'n'                     # load "n" into $t0 to compare user input in $s0

    beq $s0, $t0, userNickle        # compare $s0 with $t0 and branch to instruction label if true
    beq $s0, $t1, userNickle        # compare $s0 with $t0 and branch to instruction label if true
    j userNickleDone                # jump if not equal to userNickleDone label

    userNickle:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        lw $s2, nickle              # load penny word into $s2
        add $s4, $s4, $s2           # add it to running total 

        li $v0, 4                   # system call code for print_str
        la $a0, total               # load address of total to print to system
        syscall                     # print "Total is: "
        
        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # move $s4 into $a0 to print integer
        syscall                     # print the number

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall

        j parseInput_exit           # jump to parseInput_exit label when done printing  
    userNickleDone:

    #user enters dime -> D
    li $t0, 'D'                     # load "D" into $t0 to compare user input in $s0
    li $t1, 'd'                     # load "d" into $t0 to compare user input in $s0

    beq $s0, $t0, userDime          # branch if $s0 == $t0 to userDime label
    beq $s0, $t1, userDime          # branch if $s0 == $t1 to userDime label
    j userDimeDone                  # jump if not equal to done

    userDime:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        lw $s2, dime                # load penny word into $s2
        add $s4, $s4, $s2           # add it to running total 

        li $v0, 4                   # system call code for print_str
        la $a0, total               # load address of total to print to system
        syscall                     # print "Total is: "
        
        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # move $s4 into $a0 to print integer
        syscall                     # print the number

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall

        j parseInput_exit           # jump to parseInput_exit label when done printing 
    userDimeDone:
    
    #user enters quarter -> Q
    li $t0, 'Q'                     # load "Q" into $t0 to compare user input in $s0
    li $t1, 'q'                     # load "q" into $t0 to compare user input in $s0
    
    beq $s0, $t0, userQuarter       # branch if $s0 == $t0 to userDime label
    beq $s0, $t1, userQuarter       # branch if $s0 == $t1 to userDime label
    j userQuarterDone               # jump if not equal to done

    userQuarter:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        lw $s2, quarter             # load penny word into $s2
        add $s4, $s4, $s2           # add it to running total 

        li $v0, 4                   # system call code for print_str
        la $a0, total               # load address of total to print to system
        syscall                     # print "Total is: "
        
        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # move $s4 into $a0 to print integer
        syscall                     # print the number

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall

        j parseInput_exit           # jump to parseInput_exit label when done printing          
    userQuarterDone:
    
    #user enter fifty-cent piece -> F
    li $t0, 'F'                     # load "F" into $t0 to compare user input in $s0
    li $t1, 'f'                     # load "f" into $t0 to compare user input in $s0

    beq $s0, $t0, halfDollar        # branch if $s0 == $t0 to halfDollar label
    beq $s0, $t1, halfDollar        # branch if $s0 == $t1 to halfDollar label
    j halfDollarDone                # jump if not equal to done

    halfDollar:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        lw $s2, fifty               # load penny word into $s2
        add $s4, $s4, $s2           # add it to running total 

        li $v0, 4                   # system call code for print_str
        la $a0, total               # load address of total to print to system
        syscall                     # print "Total is: "
        
        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # move $s4 into $a0 to print integer
        syscall                     # print the number

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall

        j parseInput_exit           # jump to parseInput_exit label when done printing          
    halfDollarDone:

    #user enters dollar bill -> B
    li $t0, 'B'                     # load "B" into $t0 to compare user input in $s0
    li $t1, 'b'                     # load "b" into $t0 to compare user input in $s0

    beq $s0, $t0, dollarLabel       # branch if $s0 == $t0 to halfDollar label
    beq $s0, $t1, dollarLabel       # branch if $s0 == $t1 to halfDollar label
    j dollarLabelDone               # jump if not equal to done

    dollarLabel:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        lw $s2, dollar              # load penny word into $s2
        add $s4, $s4, $s2           # add it to running total 

        li $v0, 4                   # system call code for print_str
        la $a0, total               # load address of total to print to system
        syscall                     # print "Total is: "
        
        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # move $s4 into $a0 to print integer
        syscall                     # print the number

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall

        j parseInput_exit           # jump to parseInput_exit label when done printing
    dollarLabelDone:
    
    #user enters slug -> S
    li $t0, 'S'                     # load "S" into $t0 to compare user input in $s0
    li $t1, 's'                     # load "s" into $t0 to compare user input in $s0
    
    beq $s0, $t0, slugLabel         # branch if $s0 == $t0 to halfDollar label
    beq $s0, $t1, slugLabel         # branch if $s0 == $t1 to halfDollar label
    j slugLabelDone                 # jump if not equal to done

    slugLabel:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        li $v0, 4                   # system call code for print_str
        la $a0, slugError           # load address of newline
        syscall                     # print newline to console for Formatting
        j parseInput_exit           # jump to parseInput_exit label when done printing

        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
    slugLabelDone:
    
    #user enters return change -> R
    li $t0, 'R'                     # load "R" into $t0 to compare user input in $s0
    li $t1, 'r'                     # load "r" into $t1 to compare user input in $s0
    
    beq $s0, $t0, returnChange      # branch if $s0 == $t0 to returnChange label
    beq $s0, $t1, returnChange      # branch if $s0 == $t0 to returnChange label
    j returnChangeDone              # jump if not equal to done

    returnChange:
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        
        li $v0, 4                   # system call code for print_str
        la $a0, amntReturned        # load address of amntReturned into $a0 
        syscall                     # print prompt 

        li $v0, 1                   # system call code to print integer
        move $a0, $s4               # $a0 = $s4
        syscall                     # print the double

        li $v0, 4                   # system call code for print_str
        la $a0, centsP              # load address of cents -> $a0
        syscall
        
        la $a0, newline             # load address of newline into $a0 
        syscall                     # print newline string to console 

        # clear the registers to return change to user 
        xor $s4, $s4, $s4           # set s4 to 0
        
        j parseInput_exit           # jump to parseInput_exit
    returnChangeDone:  
    
    #user enters invalid choice
    li $v0, 4                       # system call code for print_str
    la $a0, newline                 # load address of newline
    syscall                         # print newline to console for Formatting

    li $v0, 4                       # system call for print_str
    la $a0, errorInput              # load address of errorInput 
    syscall                         # invalid choice
    
    li $v0, 4                       # system call code for print_str
    la $a0, newline                 # load address of newline
    syscall                         # print newline to console for Formatting
    
    j parseInput_Done               # jump to done 

    parseInput_exit:                # label to jump here once procedures are done

    # compare user total so far and see if greater than or equal to 55, if not then return back to main procedure 
    # Force user to make a selection if amount is greater than 200

    li $s3, 200                     # load 100 immediate into $s3
    bge $s4, $s3, cents55           # force user to make a selection if they have more than 1 dollar
    bge $s4, $s1, cents55           # branch if greater than or equal to cents55 label
    j parseInput_Done               # otherwise jump to parseInput_Done

    cents55:                        
        li $v0, 4                   # system call code for print_str
        la $a0, makeSel             # load address of coin into $a0
        syscall                     # print the prompt
        li $v0, 12                  # read character from the console
        syscall                     # read the character into $v0
        move $s6, $v0               # save the value into $s6 
        
        # User enters coke
        li $t0, 'C'                 # load character into $t0
        li $t1, 'c'                 # load character into $t1

        beq $s6, $t0, cokeL         # branch if $s0 == $t0 to returnChange label
        beq $s6, $t1, cokeL         # branch if $s0 == $t0 to returnChange label
        j cokeLDone                 # otherwise jump to coke done
        
        cokeL:
            lw $s5, cokeVar             # load word into cokeVar
            beq $s5, $zero, outofCoke   # branch if equal to zero
            j outofCokeDone             # otherwise jump to outofCokeDone
            
            outofCoke: 
                li $v0, 4                   # system call code for print_str
                la $a0, newline             # load address of newline
                syscall                     # print newline to console for Formatting

                la $a0, nodrink         # load address of newline
                syscall                 # print newline to console for Formatting

                la $a0, coke            # load address of prompt to print out
                syscall                 # print to screen
                j cents55Done           # out of coke 
            
            outofCokeDone:
            # decrement $s5 and store it back into cokeVar
            sub $s5, $s5, 1         # $s5 = $s5 - 1
            sw $s5, cokeVar         # store into variable

            li $v0, 4               # system call code for print_str
            la $a0, newline         # load address of newline
            syscall                 # print newline to console for Formatting
            la $a0, sel             # load address of prompt to print out
            syscall                 # print to screen

            la $a0, coke            # load address of coke
            syscall                 # print coke

            # Subtract 55 cents from total 
            sub $s4, $s4, $s1           # Subtract 55 from total since we made a purchase

            la $a0, change              # load address of change prompt
            syscall                     # print "Your change is "

            li $v0, 1                   # system call code for print integer 
            move $a0, $s4               # move into $a0 the value in $s4
            syscall                     # print value to screen

            li $v0, 4                   # system call code for print_str
            la $a0, centsP              # load address of centsPrompt 
            syscall                     # print " cents\n." to screen

            j cents55Done               # jump to done once we give change back to user
        cokeLDone:                  

        # User selects Sprite       
        li $t0, 'S'                     # load immediate into $t0
        li $t1, 's'                     # load immediate into $t1

        beq $s6, $t0, spriteL             # branch if $s0 == $t0 to returnChange label
        beq $s6, $t1, spriteL             # branch if $s0 == $t0 to returnChange label
        j spriteLDone                     # otherwise jump to coke done
        
        spriteL:
            lw $s5, spriteVar             # load word into cokeVar
            beq $s5, $zero, outofSprite   # branch if equal to zero
            j outofSpriteDone             # otherwise jump to outofCokeDone
            
            outofSprite: 
                li $v0, 4               # system call code for print_str
                la $a0, newline         # load address of newline
                syscall                 # print newline to console for Formatting
                la $a0, nodrink         # load address of newline
                syscall                 # print newline to console for Formatting
                la $a0, Sprite          # load address of prompt to print out
                syscall                 # print to screen
                j cents55Done           # out of coke 
            outofSpriteDone:

            # decrement $s5 and store it back into cokeVar
            sub $s5, $s5, 1         # $s5 = $s5 - 1
            sw $s5, spriteVar       # store into variable

            li $v0, 4               # system call code for print_str
            la $a0, newline         # load address of newline
            syscall                 # print newline to console for Formatting
            la $a0, sel             # load address of prompt to print out
            syscall                 # print to screen

            la $a0, sprite          # load address of coke
            syscall                 # print coke

            # Subtract 55 cents from total 
            sub $s4, $s4, $s1       # Subtract 55 from total since we made a purchase

            la $a0, change          # load address of change prompt
            syscall                 # print "Your change is "

            li $v0, 1               # system call code for print integer 
            move $a0, $s4           # move into $a0 the value in $s4
            syscall                 # print value to screen

            li $v0, 4               # system call code for print_str
            la $a0, centsP          # load address of centsPrompt 
            syscall                 # print " cents\n." to screen
            j cents55Done           # jump to done once we give change back to user
        spriteLDone:
        # User selects Dr. Pepper        
        li $t0, 'P'                 # load immediate into $t0
        li $t1, 'p'                 # load immediate into $t1

        beq $s6, $t0, drPepperL       # branch if $s0 == $t0 to returnChange label
        beq $s6, $t1, drPepperL       # branch if $s0 == $t0 to returnChange label
        j drPepperLDone                 # otherwise jump to coke done
        
        drPepperL:
            lw $s5, pepperVar             # load word into cokeVar
            beq $s5, $zero, outofpepper   # branch if equal to zero
            j outofPepperDone             # otherwise jump to outofCokeDone
            
            outofPepper: 
                li $v0, 4                   # system call code for print_str
                la $a0, newline             # load address of newline
                syscall                     # print newline to console for Formatting
                la $a0, nodrink         # load address of newline
                syscall                 # print newline to console for Formatting
                la $a0, pepper          # load address of prompt to print out
                syscall                 # print to screen
                j cents55Done           # out of coke 
            
            outofPepperDone:
            # decrement $s5 and store it back into cokeVar
            sub $s5, $s5, 1           # $s5 = $s5 - 1
            sw $s5, pepperVar         # store into variable

            li $v0, 4               # system call code for print_str
            la $a0, newline         # load address of newline
            syscall                 # print newline to console for Formatting
            la $a0, sel             # load address of prompt to print out
            syscall                 # print to screen

            la $a0, pepper          # load address of coke
            syscall                 # print coke

            # Subtract 55 cents from total 
            sub $s4, $s4, $s1       # Subtract 55 from total since we made a purchase

            la $a0, change          # load address of change prompt
            syscall                 # print "Your change is "

            li $v0, 1               # system call code for print integer 
            move $a0, $s4           # move into $a0 the value in $s4
            syscall                 # print value to screen

            li $v0, 4               # system call code for print_str
            la $a0, centsP          # load address of centsPrompt 
            syscall                 # print " cents\n." to screen

            j cents55Done           # jump to done once we give change back to user
        drPepperLDone:
        # User selects Diet Coke           
        li $t0, 'D'                 # load immediate into $t0
        li $t1, 'd'                 # load immediate into $t1

        beq $s6, $t0, dCokeL       # branch if $s0 == $t0 to returnChange label
        beq $s6, $t1, dCokeL       # branch if $s0 == $t0 to returnChange label
        j dCokeLDone                 # otherwise jump to coke done
        
        dCokeL:
            lw $s5, dcokeVar             # load word into cokeVar
            beq $s5, $zero, outofDCoke   # branch if equal to zero
            j outofDCokeDone             # otherwise jump to outofCokeDone
            
            outofDCoke:
                li $v0, 4                   # system call code for print_str
                la $a0, newline             # load address of newline
                syscall                     # print newline to console for Formatting
                la $a0, nodrink         # load address of newline
                syscall                 # print newline to console for Formatting
                la $a0, dcoke            # load address of prompt to print out
                syscall                 # print to screen
                j cents55Done           # out of coke 
            
            outofDCokeDone:
            # decrement $s5 and store it back into cokeVar
            sub $s5, $s5, 1         # $s5 = $s5 - 1
            sw $s5, dcokeVar         # store into variable

            li $v0, 4               # system call code for print_str
            la $a0, newline         # load address of newline
            syscall                 # print newline to console for Formatting
            la $a0, sel             # load address of prompt to print out
            syscall                 # print to screen

            la $a0, dcoke           # load address of coke
            syscall                 # print coke

            # Subtract 55 cents from total 
            sub $s4, $s4, $s1       # Subtract 55 from total since we made a purchase

            la $a0, change          # load address of change prompt
            syscall                 # print "Your change is "

            li $v0, 1               # system call code for print integer 
            move $a0, $s4           # move into $a0 the value in $s4
            syscall                 # print value to screen

            li $v0, 4               # system call code for print_str
            la $a0, centsP          # load address of centsPrompt 
            syscall                 # print " cents\n." to screen

            j cents55Done           # jump to done 
        dCokeLDone:
        # User selects Mellow Yellow           
        li $t0, 'M'                 # load immediate into $t0
        li $t1, 'm'                 # load immediate into $t1

        beq $s6, $t0, mellowYL       # branch if $s0 == $t0 to returnChange label
        beq $s6, $t1, mellowYL       # branch if $s0 == $t0 to returnChange label
        j mellowYLDone               # otherwise jump to coke done
        
        mellowYL:
            lw $s5, myellowVar          # load word into cokeVar
            beq $s5, $zero, outofMellow # branch if equal to zero
            j outofMellowDone             # otherwise jump to outofCokeDone
            
            outofMellow:
                li $v0, 4                   # system call code for print_str
                la $a0, newline             # load address of newline
                syscall                     # print newline to console for Formatting
                la $a0, nodrink         # load address of newline
                syscall                 # print newline to console for Formatting
                la $a0, myellow         # load address of prompt to print out
                syscall                 # print to screen
                j cents55Done           # out of coke 
            
            outofMellowDone:
            # decrement $s5 and store it back into cokeVar
            sub $s5, $s5, 1         # $s5 = $s5 - 1
            sw $s5, myellowVar      # store into variable
            
            li $v0, 4               # system call code for print_str
            la $a0, newline         # load address of newline
            syscall                 # print newline to console for Formatting
            la $a0, sel             # load address of prompt to print out
            syscall                 # print to screen

            la $a0, myellow         # load address of coke
            syscall                 # print coke

            # Subtract 55 cents from total 
            sub $s4, $s4, $s1       # Subtract 55 from total since we made a purchase

            la $a0, change          # load address of change prompt
            syscall                 # print "Your change is "

            li $v0, 1               # system call code for print integer 
            move $a0, $s4           # move into $a0 the value in $s4
            syscall                 # print value to screen

            li $v0, 4               # system call code for print_str
            la $a0, centsP          # load address of centsPrompt 
            syscall                 # print " cents\n." to screen

            j cents55Done           # jump to done 
        mellowYLDone:
        # User hits return change   
        li $t0, 'R'                 # load immediate $t0
        li $t1, 'r'                 # load immediate $t1

        beq $s6, $t0, giveChangeL    # branch if equal
        beq $s6, $t1, giveChangeL    # branch if equal 
        j giveChangeLDone

        giveChangeL:
            li $v0, 4                   # system call code for print_str
            la $a0, newline             # load address of newline
            syscall                     # print newline to console for Formatting
        
            li $v0, 4                   # system call code for print_str
            la $a0, amntReturned        # load address of amntReturned into $a0 
            syscall                     # print prompt 

            li $v0, 1                   # system call code to print integer
            move $a0, $s4               # $a0 = $s4
            syscall                     # print the double

            li $v0, 4                   # system call code for print_str
            la $a0, centsP              # load address of cents -> $a0
            syscall
            
            la $a0, newline             # load address of newline into $a0 
            syscall                     # print newline string to console 

            # clear the registers to return change to user 
            xor $s4, $s4, $s4           # set s4 to 0
            j cents55Done               # jump to done 
        giveChangeLDone:
        # If no cases fall through, user entered something wrong
        # Invalid input             # user entered something wrong, prompt the user again 
        li $v0, 4                   # system call code for print_str
        la $a0, newline             # load address of newline
        syscall                     # print newline to console for Formatting
        la $a0, errorInput          # load address of errorInput prompt
        syscall
        j cents55                   # jump to cents55 label to make user make a selection
    cents55Done: 
        # compare if we still have less than 55 cents to keep using vending machine 
        bge $s4, $s1, cents55       # branch if greater than or equal to cents55 label
    parseInput_Done:
    j promptUser                    # jump back to prompt user option
ori $v0, $0, 10                     # Sets $v0 to "10" so when syscall is executed, program will exit.
syscall # Exit.
