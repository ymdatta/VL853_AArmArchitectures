
;; Question 1:

;;  Implementation of Exponential Series  in Cortex –M4.

;;  Input: x (stored in S0)
;;  Output: e^x (stored in S4)

	 AREA     appcodes, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	;; Enabling FPU, it's disabled by default.
	
	;; Reference: http://infocenter.arm.com/help/topic/com.arm.doc.dui0553a/DUI0553A_cortex_m4_dgug.pdf
	;; 			  Section: 4.6.6
	; CPACR is located at address 0xE000ED88
	LDR.W R0, =0xE000ED88
	; Read CPACR
	LDR R1, [R0]
	; Set bits 20-23 to enable CP10 and CP11 coprocessors
	ORR R1, R1, #(0xF << 20)
	; Write back the modified value to the CPACR
	STR R1, [R0]; wait for store to complete
	;Donot execute next instructions, till DSB is completed.
	DSB
	;reset pipeline now the FPU is enabled
	ISB
	
	; Program Start
	; x in e to power of x
	; VMOV.F32 S0, #12 
	VLDR.F32 S0, =11
	
	; Number of terms to expand
	VLDR.F32 S1, =35
	
	; Numerator 
	VMOV.F32 S2, S0
	
	; Denominator
	VMOV.F32 S3, #1
	
	; Value of e to power x when expanded to n terms
	; x --> S0
	; n --> S1
	VMOV.F32 S4, #1
	
	; Temporary variable which holds value 1 & it doesn't change.
	VMOV.F32 S10, #1
	
	; First member in the series expansion is 1, and the
	; result variable is already initialised with 1.
	; So, we need to expand S1 - 1 terms.
	VSUB.F32 S1, S1, S10
	
	
	; Temporary variable for calculating factorial
	; At any iteration, say denominator is x!, the
	; S11 stores x + 1, so that when denominator is
	; updated by multiplying with S11, x! ->  (x + 1)!
	VMOV.F32 S11, S3
	
	; If, the user asks to calculate e power x till only
	; 1 term. Then since, S4 is initialised with 1, no need
	; to calculate any further.
	VCMP.F32 S1, #0.0

	; VCMP sets FPSCR Flags, not ARM Flags
	; So, let's move to ARM Core register using VMRS
	VMRS APSR_nzcv, FPSCR
	BEQ stop

loop

	; Create a temporary variable S7
	; This is used to hold Numerator / Dumerator, which is to
	; be added to result.
	VDIV.F32 S7, S2, S3
	
	; Update e power x value
	VADD.F32 S4, S4, S7
	
	;; Preparing Numerator and denominator for next iteration
	
	; Updating Numerator
	VMUL.F32 S2, S2, S0
	
	; Updating Denominator
	; S11 += 1
	VADD.F32 S11, S11, S10
	; (x + 1)! = x! * (x + 1)!
	VMUL.F32 S3, S3, S11
	
	; S1 tells how many more terms to expand to.
	VSUB.F32 S1, S1, S10
	
	VCMP.F32 S1, #0.0
	
	; VCMP sets FPSCR Flags, not ARM Flags
	; So, let's move to ARM Core register using VMRS
	VMRS APSR_nzcv, FPSCR
	
	; When S1 = 0, we have expanded to enough terms.
	; If S1 != 0, keep on looping
	BNE loop
	
stop    B stop ; stop program
     ENDFUNC
     END 