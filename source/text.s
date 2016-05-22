/* text.s
** File contains the ascii texts that are drawn to the game screen stored in global variables.  
** Also contains a global function used to draw these texts onto the screen
**
*/

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////**********************************************************************************************************************************************
** drawChar()
** - enter function description here - 
** Param:
** r0 - x coordinate of the character (top left corner)
** r1 - y coordinate of the character being drawn 
** r2 - actual ascii value of character
** r3 - color of the char
*/
.globl drawChar
drawChar:
	push	{r4-r10, lr}

	chAdr	.req	r4
	px		.req	r5
	py		.req	r6
	row		.req	r7
	mask	.req	r8
	temp	.req	r9
	color	.req	r10
		
	ldr		chAdr,	=font							// load the address of the font map
	add		chAdr,	r2, lsl #4						// char address = font base + (char * 16)
	
	mov		color,	r3
	mov		temp,	r0								//init the X coordinate (pixel coordinate
	mov		py,		r1								// init the Y coordinate (pixel coordinate)

charLoop$:
	mov		px,		temp							//init the X coordinate (pixel coordinate
	mov		mask,	#0x01							// set the bitmask to 1 in the LSB
	ldrb	row,	[chAdr], #1						// load the row byte, post increment chAdr

rowLoop$:
	tst		row,	mask							// test row byte against the bitmask
	beq		noPixel$

	mov		r0,		px
	mov		r1,		py
	mov		r2,		color
	bl		drawPixel								// draw blue pixel at (px, py)

noPixel$:
	add		px,		#1								// increment x coordinate by 1
	lsl		mask,	#1								// shift bitmask left by 1
	tst		mask,	#0x100							// test if the bitmask has shifted 8 times (test 9th bit)
	beq		rowLoop$

	add		py,		#1								// increment y coordinate by 1
	tst		chAdr,	#0xF
	bne		charLoop$								// loop back to charLoop$, unless address evenly divisibly by 16 (ie: at the next char)

	.unreq	chAdr
	.unreq	px
	.unreq	py
	.unreq	row
	.unreq	mask

	pop		{r4-r10, pc}

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////**********************************************************************************************************************************************
** drawText()
** - prints out a line of text with the coordinates and color specified in the arguments
** Params:
** r0 - x coordinate of the text (from the top left corner)
** r1 - y coordinate of the text
** r2 - base address of asciz text
** r3 - color of the text
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////**********************************************************************************************************************************************
*/
.globl drawText
drawText:

	push {r4-r9, lr}
	charOffset  .req  r4							//required for accessing each char in the ascii text
	char		.req  r5							//char will contain the current letter we want to draw
	px			.req  r6							//starting x and y coordinates for the text
	py			.req  r7
	color		.req  r8
	textAddr	.req  r9
			
	//init offset and coordinates
	mov		charOffset, #0
	mov		px,	  r0
	mov		py,	  r1

	//save the address of the text and color in variables
	mov		textAddr,	r2
	mov		color,  	r3
	
	//loop draws each character of the ascizz until it reaches its end '\0' value
textLoop$:
			
	ldrb	char,	[textAddr, charOffset]
	cmp		char, 	#0
	beq		doneText$
		
	mov		r0,	px
	mov		r1,	py
	mov		r2,	char
	mov		r3,	color
		
	bl 		drawChar 						

	add		px,		#8	
	add		charOffset,	#1
	bal		textLoop$

doneText$:	

	.unreq  charOffset  
	.unreq  char		  
	.unreq  px			 
	.unreq  py			 
	.unreq	color		 
	.unreq  textAddr	 
	 pop {r4-r9, pc}

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////**********************************************************************************************************************************************
*/

.section .data

.align 4
.globl font
font:		.incbin	"font.bin"

.globl livesTitle
livesTitle:
	.asciz "Lives: "

.globl authorsTitle
authorsTitle:
	.asciz "Created by: Ahmad Turkmani, Matthew Bauman and Nasir Osman"

.globl scoreTitle
scoreTitle:
	.asciz "Score:"

.globl gameOverText
gameOverText:
	.asciz "Game Over"

.globl gameWonText
gameWonText:
	.asciz "You have won!" 

.globl	gameTitle
gameTitle:
	.asciz "Pac Man v3.14"

.globl winMsg
winMsg:
	.asciz "You Win!"

.globl loseMsg
loseMsg:
	.asciz "Game Over!"

//end text.s
