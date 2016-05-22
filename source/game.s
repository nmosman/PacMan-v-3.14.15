/*Game.s
** File contains many of the functions that govern the game logic being used
*/

///////////////////
//   Constants	 //										   
///////////////////

//Map Constants
/////////////////
mapSize		= 462
mapHeight	= 22
mapWidth	= 21

//Counts
////////////////
maxPellets = 168
maxLives = 3
minScore  = 0

//Tile Constants
////////////////////////////////////////
tileWidth = 16
tileHeight = 16
pixelsPerTile = tileWidth * tileHeight

//Main Screen Offsets
///////////////////////////////////////////////
xScreenOffset = (1024 -  tileWidth*mapWidth)/2
yScreenOffset = (768 -  tileHeight*mapHeight)/2

//Score Offsets
///////////////////////////////////////////////
scoreXoffset = (xScreenOffset - 16*3)*2 
scoreNum1Xoffset = (xScreenOffset - 16*3)*2 +48
scoreNum2Xoffset = (xScreenOffset - 16*3)*2 +56
scoreNum3Xoffset = (xScreenOffset - 16*3)*2 +64

//Text Offsets
/////////////////////////////////
wordYoffset = yScreenOffset - 16
nameXoffset = xScreenOffset - 52
nameYoffset = wordYoffset +  384
titleXOffset = xScreenOffset + 103
titleYOffset = yScreenOffset - 32
livesNumberXOffset = xScreenOffset + 48 
finalGameYOffset = yScreenOffset + 160
finalGameXOffset = titleXOffset +32

//Other Constants
////////////////////
livesAsciiValue = 51
skipGhostLimit = 4
gameLoopDelay = 100000
clearButtons =  0xFFFF

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** divideByNumber()
** - Division algorithm used to compute both a quotient and remainder of a dividend
** Param:
** r0 - is a dividend
** r1 - is the divisor
** Returns:
** r0 - resulting quotient of the division operation
** r1 - resulting remainder of the operation
** 
*/
.globl divideByNumber
divideByNumber:
	
	mov 	r2, r0				
	mov		r0, #0

divideByNumberLoop:

	cmp		r2, r1								//If divisor < dividend, we are finished the loop
	blt		endDivideByNumber

	sub		r2, r1	//r2 -= r1					//Otherwise dividend := dividend - divisor
	add		r0, #1	//r0++						//Increment the number of times the divisor divides the dividend

	b		divideByNumberLoop

endDivideByNumber:

	mov		r1, r2								//r1 now contains the result remainder of the performed division

	mov		pc, lr

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** loseGame()
** - enter function description - 
** 
*/
.globl loseGame
loseGame:
	
	//reset lose flag
	mov		r0,	#0
	ldr		r1,	=loseFlag
	str		r0,	[r1]

	ldr 	r0,	=loseMsg
	bl   	drawGameEndScreen

	//wait 2 seconds
	ldr 	r0, 	=2000000
	bl 		wait

	//prompt for user input
	bal		endGameButtonListener

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** winGame()
** - enter function description - 
** 
*/
.globl winGame	
winGame:

	//reset win flag
	mov		r0,	#0
	ldr		r1,	=winFlag
	str		r0,	[r1]

	ldr 	r0,	=winMsg
	bl      drawGameEndScreen

	//wait 2 seconds	
	ldr		r0,     =2000000
	bl		wait

	//prompt for user input
	bal		endGameButtonListener

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** drawGameEndScreen()
** - enter function description - 
** Param:
** r0 - address of the game message to display at the end of the game
**
*/
drawGameEndScreen:
	
	push		{r4-r8, lr}

	msgText	 .req   r9
	counter1 .req 	r5
	counter2 .req   r4

	//save the address of the msgText to be drawn
	mov		msgText,	r0

	mov		counter1,	#0
	
	//144px is the starting y position of the rows to be drawn to the screen
	mov		r6,	#144

	//16px is x offset of each black tile draw
	mov		r7,	#16

//draws three rows of black tiles right in the middle of the game screen
outerLoop$:

	cmp		counter1,	#3
	bge		doneDrawWin$
	
	//counter 2
	mov		counter2, 	#0
	
drawWinTop$:

	cmp		counter2,	#mapWidth
	bge		outerLoopInc$				
	
	mov		r0,	#0
	mov		r1, #0		
	add		r0,	counter2, lsl #4 								// add the tile offset by 16 each iteartion			
		
	mla		r8,	counter1, r7, r6								// r8 = 144 + counter1 *16, required for offseting by a row each outer loop iteration			
	add		r1,	r8
	ldr 	r2,		=floorTile										
	bl  	drawTile
	add		counter2,	#1
	bal		drawWinTop$

outerLoopInc$:
		
	add		counter1,	#1
	bal		outerLoop$

doneDrawWin$:
	
	//draw end game screen
	ldr		r0,	=finalGameXOffset	
	mov		r1,	#finalGameYOffset
	mov		r2,	msgText	
	ldr		r3,	=0xFFFF00
	bl		drawText

	.unreq	counter1
	.unreq	counter2

	pop 	{r4-r8, pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
**	endGameButtonListener()
**  - Required after the game ends to prompt user for button press in order to restart the game 
** 
*/
endGameButtonListener:

	bl		getSNESInput
	ldr		r1,	=clearButtons

	//if any button is pressed, restart game	
	cmp		r0,	r1
	bne		resetData
	bal		endGameButtonListener	

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** initializeGame()
** - Sets up the frame buffer, the snes controller as well as the game board and characters
** 
*/
.globl initializeGame
initializeGame:

	push	{lr}
	bl		InitFrameBuffer

	bl		initSNES
	
	//map type required as arg for drawing game board
	ldr 	r0,	=resetMap

	bl		drawGameBoard
	bl		initCharacters
	pop 	{pc}

/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** resetData()
** - Resets the entire game including the players score and lives, pac mans position, the ghosts position, drawn texts and the entire map state. 
**
*/
.globl resetData
resetData:
	push	{r4-r7, lr}

	//reset lives back to 3 
	mov		r5,	#3
	ldr		r4,	=lives
	str		r5, [r4]

	//clear the previous lives count from the screen
	mov		r0,	#livesNumberXOffset
	mov		r1,	#wordYoffset
	ldr		r2,	=asciiLives
	ldr		r3,	=0x0
	bl		drawText

	//reset the ascii value of lives to 51
	mov		r5,	#livesAsciiValue
	ldr		r4,	=asciiLives
	str		r5, [r4]

	//redraw the current lives value onto the screen
	mov		r0,	#livesNumberXOffset
	mov		r1,	#wordYoffset
	ldr		r2,	=asciiLives
	ldr		r3,	=0xFFFF00
	bl		drawText

	//reset pellet size back to 168
	mov		r5,	#maxPellets
	ldr		r4,	=pellets
	str		r5, 	[r4]

	//reset the check point to start position
	ldr		r1,	=checkPointCoords
	ldr		r2,	=pacStartCoords
	

	//store the start positions into the check point coords
	ldmia	r2,	{r3,r4}
	stmia	r1,	{r3,r4}

	ldr		r3,	=pacStartPos
	ldr		r4,	=curCheckPoint

	//store the start offset into curCheckPoint
	ldr		r3,	[r3]	
	str		r3,	[r4]

	//reset the ghost coordinates
	ldreq	 r4, =ghostStartPos
	ldreq	 r5, =ghostCurPos
	ldmeqia	 r4, {r0-r3}
	stmeqia  r5, {r0-r3}
	
	//reset pac mans position
	ldr 	r4,	=pacStartCoords
	ldr		r5,	=pacCoords	

	//r6 is x, r7 is y 
	ldr		r6,	[r4]
	ldr		r7,	[r4,#4]
	
	//store the reset coordinates into pacs current position
	str		r6,	[r5]
	str		r7,	[r5,#4]

	//restart pac mans offset
	ldr		r6,	=pacStartPos
	ldr		r6,	[r6]
	ldr		r7,	=pacCurPos
	str		r6,	[r7]
	
	//reset the score to zero
	ldr		r5, =score
	mov		r6,	 #0
	str		r6,	[r5]	
	
	//reset the saved score as well
	ldr		r5, =savedScore
	mov		r6,	 #0
	str		r6,	[r5]

	//reset the saved pellet count to 168
	ldr		r5, =savedPellets
	mov		r6,	 #168
	str		r6,	[r5]

	//reset the check point map 
	cpmctr	.req	r0
	mov		cpmctr, 	#0
	ldr		r1,	=mapSize
	ldr		r2,	=checkPointMap
	ldr		r3,	=resetMap


//loop required to reset the checkPointMap back to the initial game map
cpmReset$:
	
	cmp		cpmctr,	r1
	bge		cmpEnd$
	
	ldrb	r4,	[r3,cpmctr]
	strb	r4,	[r2,cpmctr]
	
	add		cpmctr,  #1
	
	bal		cpmReset$

cmpEnd$:
	
	//ghost reset counter
	grctr	.req	r1												
	mov		grctr,	#0

	//get both ghost current and initial coordinates
	ldr		r2,	=ghostStartCoordinates
	ldr		r3,	=ghostCoordinates
	

//loop required to update the ghosts position back to their respective start positions
ghostResetLoop$:
	
	//required to loop from 0-7 (eight times as each of the 4 ghosts have an x and y coordinate)
	cmp		grctr,	#8
	bge		ghostResetDone$
		
	//r4 has x coordinate of the ghost
	ldr		r4,	[r2, grctr,lsl #2]

	mov		r0,	grctr
	add		r0,	#1

	//r5 has y coordinate of the ghost
	ldr		r5,	[r2, r0, lsl #2]

		
	//store the reset coordinates into current coordinates 
	str		r4,	[r3, grctr,lsl #2]
	str		r5, [r3, r0, lsl #2]

	//offset on to the next pair of coordinates
	add		grctr, 	#2

	bal		ghostResetLoop$
			

ghostResetDone$:
	.unreq	grctr

	//reset map counter
	rctr    .req	r0
	mov		rctr, 	#0
	ldr		r1,	=mapSize
	ldr		r2,	=currentMap
	ldr		r3,	=resetMap

//loop required for resetting the current map into the initial game map
resetMap$:
	
	cmp		rctr,	r1
	bge		doneReset$					
	
	ldrb	r4,	[r3,rctr]									//load reset map value at each tile 
	strb	r4,	[r2,rctr]									//and store them onto corresponding current map position
	
	add		rctr,  #1
	bal		resetMap$

doneReset$:

	.unreq	rctr 
	pop		{r4-r7}
	b	main	

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** collisionCheck()
**  - This function is responsible for handling the possiblity of collision between pac man and any of the ghosts
**
*/
.globl collisionCheck
collisionCheck:

	push 	{r4-r6, lr}
	counter .req r7
	mov	counter,	#0

//loop checks through each ghost	 
loop$:

	ldr		r0,	=ghostCurPos
	ldr		r2,	=pacCurPos
	ldr		r3,	[r2]
	cmp		counter,	#4
	popge   {r4-r6, pc}
	
	ldr		r4, 	[r0,counter, lsl #2]

	//check to see if pac man's position is equal to any of the ghosts' position
	cmp		r4, r3
	
	//if so, there was a collision. Then update pac man's stats.
	beq		updatePac$

	//otherwise, check for another ghost
	addne	counter, #1
	bne		loop$

updatePac$:

	//update pac man's lives
	ldr		r5, =lives
	ldr		r6, [r5]
	sub		r6, #1
	
	//if pac man's lives sets to zero, set the lose flag
	cmp		r6,	#0
	ldreq 	r7,	=loseFlag
	moveq	r1,	#1
	streq	r1,	[r7]
	str		r6, [r5]
	
	//update pac mans pellet count to its previous one
	ldr		r6,	=savedPellets
	ldr		r6,	[r6]	
	ldr		r5, =pellets
	str		r6,	[r5]


	//getting the last check points position
	ldr		r5, =curCheckPoint
	ldr		r6, [r5]
	
	//update pac mans position to the curCheckPoint
	str		r6, [r2]
	ldr		r5, =checkPointCoords
	ldmia 	r5, {r0, r1}
	ldr		r5, =pacCoords
	stmia 	r5, {r0, r1}
	
	//put the saved score into score
	ldr		r1,	=savedScore
	ldr		r2,	=score
	ldr		r1,	[r1]
	str		r1,	[r2]

	ldr		r1,		=currentMap
	ldr		r2,		=checkPointMap

	//pac man reset to check point (pr) counter 
	prctr	.req	r0
	ldr		r3,		=mapSize

//loop stores each value from the checkPointMap onto the currentMap
prLoop$:
	cmp		prctr,	r3
	bge		prEnd$
	
	ldrb	r5,	[r2,prctr]
	strb	r5,	[r1,prctr]
	add		prctr,  #1
	
	bal		prLoop$

prEnd$:
	
	//send the ghosts back home		
	ldr		 r4, =ghostStartPos
	ldr		 r5, =ghostCurPos
	ldmia	 r4, {r0-r3}
	stmia 	 r5, {r0-r3}
	

	//clear the previous lives count from the screen
	mov		r0,	#livesNumberXOffset
	mov		r1,	#wordYoffset
	ldr		r2,	=asciiLives
	ldr		r3,	=0x0  										//load black font to draw over previous score
	bl		drawText

	//update lives ascii values
	ldr		r5, =asciiLives
	ldr		r6, [r5]
	sub 	r6, #1
	str		r6, [r5]

	
	//if there was a collision, terminate the loop

	pop 	{r4-r6, pc} 

/*		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** checkGameState()
** - Checks both game state flags and branches either to the win/lose game result depending on the set flag
** 
*/
.globl checkGameState
checkGameState:

	ldr		r0,	=winFlag
	ldr		r0,	[r0]
		
	ldr		r1,	=loseFlag
	ldr		r1,	[r1]
		
	cmp		r0,	#1
	beq		winGame

	cmp		r1,	#1
	beq		loseGame

	mov		pc,	lr

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** processGhostsMove()
** - carries out the movement of the ghosts as well as processing the collision afterwards. 
** - Also slows down the high speed of the ghosts' movement 
** 
*/
.globl processGhostsMove
processGhostsMove:

	push	{lr}

	ldr		r1,	=ghostSpeedCounter
	ldr		r2,	[r1]
	cmp		r2,	#skipGhostLimit								//if counter reaches 4, carry out ghost's movement, otherwise skip it
	moveq   r2,	#0
	addne	r2,	#1
	str		r2,	[r1]
	bne		skipGhostMove$

	//function that actually carries out the ghost's movement
	bl		moveGhosts

	//check for collision after the ghost's make their moves
	bl		collisionCheck
	

//required to delay ghost speed
skipGhostMove$:
				
	pop		{pc}		

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** - delayGame()
** delays the game loop by a specified time (in the gameLoopDelay constant) to optimize the game speed for playability
**
*/
.globl delayGame
delayGame:

	//store the clock time before the loop starts
	ldr		r1,		=0x20003004
	ldr		r1,		[r1]
	ldr		r2,		=lastObservedTime
	ldr		r2,		[r2]

	//compare previous saved time with the current
	sub		r1,		r2
	ldr		r3,		=gameLoopDelay
	cmp		r1,	r3
	blo		delayGame
	

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** - saveCurrentTime()
**	gets current time and stores it into memory
**
*/
.globl saveCurrentTime
saveCurrentTime:

	//store the clock time before the loop starts
	//required for delaying the game speed
	ldr		r1,	=0x20003004
	ldr		r1,	[r1]
	ldr		r2,	=lastObservedTime
	str		r1,	[r2]


.section .data

///////////////////////////////
//   Game State Variables	 //										   
///////////////////////////////

.globl score
score:
	.int	0

.globl savedScore
savedScore:
	.int	0

.globl lives
lives:
	.int	3

.globl pellets
pellets:
	.int 	168

.globl	savedPellets
savedPellets:
	.int	168

.globl winFlag
winFlag:
	.int	0

.globl	loseFlag
loseFlag:
	.int	0

///////////////////////////
//  Other 	Variables	 //										   
///////////////////////////


//used for optimizing ghost's speed
.globl	ghostSpeedCounter
ghostSpeedCounter:
	.int	0
 
//used for printing out lives 
.globl asciiLives
asciiLives:
	.int	51

//used for printing out the score
 .globl scoreDigits
scoreDigits:
	.byte 0, 0, 0, 0

//used for optimizing game speed
.globl lastObservedTime
lastObservedTime:
	.int	0

	
