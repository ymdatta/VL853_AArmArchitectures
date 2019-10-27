;; Question 6:

;; Here is C program to find GCD of two numbers, Re-Write this for CORTEX –M4
;; Program: When two inputs are given manually in R0, R1 the G.C.D of those
;;		    two numbers is stored in R4.

	 AREA     appcodes, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	; Result is stored in R4.
	MOV R4, #0
	
	; Store the numbers in R0, R1
	MOV R0, #72
	MOV R1, #84
	
; loop is a PC-relative expression.
loop
		; First compare R0 and R1
		CMP R0, R1

		ITE GT
		; If R0>R1 then R0 = R0 - R1
		SUBGT R0, R0, R1
		; Else then R1 = R1 - R0
		SUBLE R1, R1, R0
		
		; Again compare R0, R1
		CMP R0, R1
		
		; If R0 != R1, loop again
		BNE loop
		
	; Result is stored in _R4_	
	MOV R4, R0
	
stop    B stop ; stop program
     ENDFUNC
     END 