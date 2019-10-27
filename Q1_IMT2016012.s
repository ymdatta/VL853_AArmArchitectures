;; Question 1:

;;  Implement Fibonacci  series using Cortex M4.
;;  Program: When an input is given manually in R3, let it be n,
;;			 then Fib(n) is calculated and stored in R0.

	 AREA     appcodes, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	;; Input and output.
	; Result is stored in R0
	MOV R0, #0
		
	; Store the input in R3, i.e R3 element of Fibonacci series
	MOV R3, #8 ;; Value 0x15(i.e 21) should be stored in R0, after program is executed. 
	;; For a large number like 30, value 0xCB228 (i.e 832040) should be stored in R0.
	

	;; Variable Initialisation.
	; Intial Fibonacci values
	MOV R1, #0
	MOV R2, #1

	
	;; Logic for finding Fibonacci at n.
	; Case when input is 0, i.e first element of Fibonacci Series.
	CMP R3, #0
	
	; If input is < 0, stop the program.
	IT LT
	BLT stop
	
	IT EQ
	MOVEQ R4, R1
	BEQ stop
	
	; Case when input is 1, i.e second element of Fibonacci Series.
	CMP R3, #1
	
	IT EQ
	MOVEQ R4, R2
	BEQ stop
	
	; We have already calculated one Fibonacci numbers, so we need to
	; Calculate only n - 1 times. (We already calculated for n = 1)
	SUB R3, R3, #1
	
loop

	; Update R1 and R2
	; At nth iteration Fib(n) is stored in R0.
	ADD R0, R1, R2
	MOV R1, R2
	MOV R2, R0
	
	; Subract R3 by 1, so that the loop exits after n - 2 iterations.
	SUB R3, R3, #1
	CMP R3, #0
	
	; Loop again only if R3 != 0
	BNE loop
	
	;; Result is stored in R0.
	
stop    B stop ; stop program
     ENDFUNC
     END 