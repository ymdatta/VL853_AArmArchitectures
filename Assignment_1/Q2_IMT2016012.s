;; Question 2:

;;  Given three number find the largest of the three using Cortex M4
;;  Program: Input is given in R0, R1, R2 manually, and the greatest
;;			 of these three numbers is stored in R4. i.e Result is stored
;;		     in R2.

	 AREA     appcodes, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	 ; Store the three numbers in R0, R1, R2 resp.
	 
	 MOV R0, #12
	 MOV R1, #14
	 MOV R2, #13
	 
	 ; Result is stored in R4
	 MOV R4, #0

	 ; Compare R0, R1 and store the larger number in R5
	 CMP R0, R1
	 
	 ITE GE
	 MOVGE R5, R0
	 MOVLT R5, R1

	 ; Compare R5, R2 and store the larger number in R4
	 ; R4 is the largerst number of R0, R1, R2.
	 CMP R5, R2
	 
	 ITE GE
	 MOVGE R4, R5
	 MOVLT R4, R2
	 
	 ;R4 now contains the largest number.
	
stop    B stop ; stop program
     ENDFUNC
     END 