/* snes.s
** This file is mainly responsible for the functions that enable input from the SNES Controller
*/

.section .text

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** initSNES()
** - Initializes the snes controller for input and output
**
*/
.global initSNES
initSNES:
	push 	{lr}
	
	// set GPIO pin 11 (Clock) to output
	mov 	r0, #11
	mov 	r1, #1
	bl  	setGPIO
	
	// set GPIO pin 9 (Latch) to output
	mov 	r0, #9
	mov 	r1, #1
	bl  	setGPIO

	// set GPIO pin 10 (Data) to input
	mov 	r0, #10
	mov 	r1, #0
	bl  	setGPIO

	pop 	{pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** setGPIO()
** - Selects function mode on provided pin 
** Params:
** r0 -  will have #pin, 
** r1 -  contains function select mode (eg. 000 for input, 001 for output)
**
*/
setGPIO:
	
	ldr 	r2, =0x20200000      			//base addr

	cmp 	r0, #9							//If pin 9, continue
	subhi 	r0, #10							//Else, subtract 10
	addhi 	r2, #4							//and add 4 to base address			
			
	
	ldr 	r3, [r2]				
	mov 	r4, #7              			//required for clearing pin
	add 	r0, r0, lsl #1					//r0 = r0 + r0*2
	lsl 	r4, r0	         				//align bit mask
	bic 	r3, r4		 				
   	
	// Input or Output select 
	lsl 	r1, r0							//shift select mode by pin number
	orr 	r3, r1
	str 	r3, [r2]	        			// store the changes back into the address

	mov 	pc, lr

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** writeGPIO()
** - this function is to write or clear a pin.
** Params:
** r0 - will contain the #pin, r1 will be the write value (0,1)
**
*/
writeGPIO:
	
	ldr 	r2, =0x20200000					//base addr
	mov 	r3, #1
	lsl 	r3, r0							//align pins
	teq 	r1, #0							//test to see if we are given 1 or 0 as arg
	streq 	r3, [r2, #40] 					// write 1 to GPCLR0 (means write 0)
	strne 	r3, [r2, #28] 					// write 1 to GPSET0 (means write 1)
	mov 	pc, lr

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** readGPIO()
** - this function is to read the pin for signal 0,1
** Params:
** r0 - will contain the #pin
** Returns:
** r0 - read value in r0
**
*/
readGPIO:
	
	ldr 	r2, =0x20200034			 		//addr
	ldr 	r2, [r2]
	mov 	r3, #1
	lsl 	r3, r0							//align pins
	and 	r2, r3
	teq 	r2, #0							//read the pin
	moveq 	r0, #0           				//return 0
	movne 	r0, #1 	       					//return 1
	mov 	pc, lr

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** wait()
** - This function delays 
** Params:
** r0 - is the delay time in microseconds
** 
*/
.globl wait
wait: 
	
	ldr 	r1, =0x20003004     			// address of CL0
	ldr 	r2, [r1]          				// read CLO
	add 	r2, r0        	   				// add delay to read time

delayLoop$:
		
	ldr 	r3, [r1]						//get the current time
	cmp 	r2, r3          				// finish if current time = original time + delay
	bhi 	delayLoop$						// if not loop back
	mov 	pc, lr

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** getSNESInput()
** - this function is used to read the snes controller
** Returns:
** r0 - sampled buttons register from user input
*/
.globl getSNESInput
getSNESInput:

	push 	{r4-r5,lr} 

	buttons .req  r4
	i       .req  r5		
	mov 	i, #0							//counter
	mov     buttons, #0						//buttons register
	
	// write 1 to GPIO pin 11 (Clock)
	mov 	r0, #11
	mov 	r1, #1
	bl  	writeGPIO
	
	// write 1 to GPIO pin 9 (Latch)
	mov 	r0, #9
	mov 	r1, #1
	bl  	writeGPIO
	
	// wait 12 micro seconds
	mov 	r0, #12
	bl  	wait
	
	// write 0 to GPIO pin 9 (Latch)
	mov 	r0, #9
	mov 	r1, #0
	bl  	writeGPIO
  	mov 	i, #0

//start pulsing inorder to read from snes controller.	
pulseLoop$:
	
	cmp 	i, #16							//get 16 inputs, the amount of buttons in snes
	bge 	doneloop$
	
	// wait 6 micro seconds 
	mov 	r0, #6
	bl 		wait

	// write 0 to GPIO pin 11 (Clock)
	mov 	r0, #11
	mov 	r1, #0
	bl  	writeGPIO

	// wait 6 micro seconds 
	mov 	r0, #6
	bl  	wait

	// read from data line r0= gpio pin #10
	mov 	r0, #10
	bl  	readGPIO
	
	// store return value r0 into buttons
	lsl 	r0, i							//shift by counter to read the right button
	orr 	buttons, r0						//bitwise or buttons register with r0 to store bit value in buttons register
	add 	i, #1

	
	// write 1 to GPIO pin 11 (Clock)
	mov 	r0, #11
	mov 	r1, #1
	bl  	writeGPIO 
	
	bal 	pulseLoop$
	
doneloop$:
	 
	mov 	r0,	buttons
	.unreq	buttons
	.unreq	i

	pop 	{r4-r5, pc}

//end snes.s
