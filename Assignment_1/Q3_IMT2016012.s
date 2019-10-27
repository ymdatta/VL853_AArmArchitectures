;; Question 3:

;; Given a number find out whether it is even or ODD in Cortex M4
;; Program: When a number is given as an input in R0 manually, then
;;	        we store result in R3.

;; After execution of program, if R3 contains 1: then the number in R0 is odd else even.
	 AREA     appcodes, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	 ;Store the number in R0.
	 MOV R0, #13 ;Odd
	 ;MOV R0, #12
	 
	 ;Move 2 to R2, as UDIV expects integer register
	 MOV R1, #2

	 ;We now need to do modulus operation on R0
	 ;We achieve this by using UDIV + MLS
	 
	 ;UDIV finds the divisor i.e R0/R1
	 UDIV R2, R0, R1
	 
	 ;Register R3 contains either 0 0r 1.
	 ;If it contains zero, then number in R0 is an even, else odd.
	 
	 ;Here, we are essentially doing R3 = R0 - (R1 x R2)
	 MLS R3, R1, R2, R0
	
stop    B stop ; stop program
     ENDFUNC
     END 