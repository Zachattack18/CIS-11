;CIS11 Project
;Zach Hill, Kevin Coronado, David Rodriguez
;This program is used to display a letter grade based on
;min, max and average values.

.ORIG x3000
LD R3, GRADES 
JSR TOPGRADE			; subroutine for highest grade among all 5 grades
JSR LOWESTGRADE			; subroutine for lowest grade among all 5 grades
JSR AVERAGEGRADE		; subroutine for calculations of average grade 
HALT


TOPGRADE
	AND R0, R0, #0		; Initialize R0 to 0
	LD R1, NTESTS		; holds the number of test scores
LOOP1  LDR R2, R0, #0		; incrementing to get next student's grade
	ADD R3, R3, #1
	NOT R4, R0
	ADD R4, R4, #1		; R4 = -R1, R1 has the top grade
	ADD R5, R2, R4
	BRnz SKIP1	
	AND R0, R0, #0
	ADD R0, R0, R2		; update the top grade to the current's student's grade
SKIP1	ADD R1, R1, #-1		; decrementing, counter R1
	BRp LOOP1 		; Continue to loop
	STI R1, TOP_GRADE	; Store top grade
	LD R3, GRADES		; restore R3

RET				; Return to JSR TOPGRADE

LOWESTGRADE
	LD R0, LOWEST_GRADE	; R0 holds the min score seen
	LD R1, NTESTS		; R1 holds the number of tests = 5
LOOP2	LDR R2, R1, #0		; R2 is the grades
	ADD R0, R0, #1		; Incrementing to get the next grade
	NOT R3, R2		; Negate R3 put into R3
	ADD R3, R3, #1		; add +1 into R3 
	ADD R4, R0, R3		
	BRnz SKIP2		
	AND R0, R0, #0
	ADD R0, R0, R2		; update the lowest grade to the current grade
SKIP2	ADD R1, R1, #-1		; counter R1
	BRp LOOP2		; continue loop until 5 grades seen
	LD R5, LOWEST_GRADE	; R5=x5000
	STR R0, R5, #1		; store lowest grade to x4001
	LD R3, GRADES		; restore R3 to x4000 for next subroutine
RET				;Return to JSR LOWESTGRADE

AVERAGEGRADE
	AND R0, R0, #0			; Clear R0, initialize to zero
	LD R1, NTESTS			; number of tests, 5
	LDR R2,R3, #0			; test grade
	ADD R3, R3, #1			; incrementing to get next grade
	ADD R0, R0, R2			; update the sum of grades to R0
	ADD R1, R1, #-1			; counter R1
	BRp LOOP1			; Loop hasn't looked at 5 grades
	
	LD R1, NTESTS			; Division
	NOT R1, R1
	ADD R1, R1, #1
	AND R2, R2, #0			; result stored in R2

LOOPDIV	ADD R0, R0, R1			; decrement
	BRnz STOP		
	ADD R2, R2, #1			; Increment
	BRnzp LOOPDIV			; continue dividing
STOP	ADD R2, R2, #1			; Stop dividing 
	LD R4, AVERAGE_GRADE			
	STR R3, R4, #2			;Store average into R3
	LD R3, GRADES			; restore R3 
	RET				; Return to JSR AVERAGEGRADE
LAST HALT	
NTESTS		.FILL 5
GRADES		.FILL x4000
TOP_GRADE	.BLKW 1
LOWEST_GRADE	.BLKW 1
AVERAGE_GRADE	.BLKW 1

.END
