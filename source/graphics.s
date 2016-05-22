/* graphics.s 
** Contains all the necessary functions in order to draw all the graphics of the game onto the 
*/

.section .init

///////////////////
//   Constants	 //										   
///////////////////


//Map and Tile Constants
///////////////////////////////////////////////
mapHeight	= 22
mapWidth	= 21
mapSize = mapHeight * mapWidth
tileWidth = 16
tileHeight = 16
tileSize = tileWidth * tileHeight


//Screen Offsets
///////////////////////////////////////////////
xScreenOffset = (1024 -  tileWidth*mapWidth)/2
yScreenOffset = (768 -  tileHeight*mapHeight)/2


//Score Offsets
///////////////////////////////////////////////
scoreXoffset = (xScreenOffset - 16*3)*2 
scoreNum1Xoffset = (xScreenOffset - 16*3)*2 +48
scoreNum2Xoffset = (xScreenOffset - 16*3)*2 +56
scoreNum3Xoffset = (xScreenOffset - 16*3)*2 +64
scoreRefreshX   = 294
scoreRefreshOffset = -16


//Text Offsets
///////////////////////////////////////////////
titleXOffset = xScreenOffset + 103
titleYOffset = yScreenOffset - 32
livesNumberXOffset = xScreenOffset + 48
wordYoffset = yScreenOffset - 16
nameYoffset = wordYoffset +  384
nameXoffset = xScreenOffset - 52 
//finalGameYOffset = yScreenOffset + 160
//finalGameXOffset = titleXOffset +32


.section .text
/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** drawPixel()
** - enter function description
** Param:
** r0 - x coordinate of the pixel
** r1 - y coordinate of the pixel
** r2 - color of the pixel in hex code
**
*/
.globl drawPixel
drawPixel:
    
    px		.req	r0
    py		.req    r1
   	color	.req	r2
    addr	.req    r3

    push	{r4}
    
    ldr     addr,   =FrameBufferInfo
    
   	height  .req    r4
    ldr     height, [addr, #4]
    sub     height, #1
    cmp     py,     height					//if y coordinate is greater than height, return
    movhi   pc,     lr
    .unreq  height
    
    width   .req    r4
    ldr     width,  [addr, #0]
    sub     width,  #1
    cmp     px,     width					//if x coordinate is greater than height, return
    movhi   pc,     lr
    
    ldr     addr,   =FrameBufferPointer
	ldr		addr,	[addr]
	
    add     width,  #1						//reset width to original value
    
    mla     px,     py, width, px       	//px = (py * width) + px
    .unreq  width
    .unreq  py
    
    add     addr,   px, lsl #1				//addr += (px * 2) (ie: 16bpp = 2 bytes per pixel)
    .unreq  px
    
    strh    color,  [addr]					//store the color into its coresponding coordinates in memory
    
    .unreq  addr
    
	pop		{r4}

    bx		lr

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////**********************************************************************************************************************************************
** drawTextScreen()
** - Draws every ascii text required in the game onto the screen
*/
drawTextScreen:

	push	{lr}
	
	//set up args for drawing lives
	ldr		r0, =xScreenOffset								
	ldr		r1,	=wordYoffset
	ldr 	r2, =livesTitle
	ldr		r3,	=0xFFFF00
	bl		drawText

	//args for drawing authors
	ldr		r0, =nameXoffset
	ldr		r1,	=nameYoffset
	ldr 	r2, =authorsTitle
	ldr		r3,	=0xFFFF00
	bl		drawText
	
	//args for drawing the score
	ldr		r0,	=scoreXoffset
	ldr		r1, =wordYoffset	
	ldr		r2,	=scoreTitle
	ldr		r3,	=0xFFFF00
	bl 		drawText
	
	//draw the score value onto the screen
	ldr		r0, =0xFFFF00
	bl 		updateScoreOnScreen

	//args for drawing the game title
	ldr		r0,	=titleXOffset
	ldr		r1,	=titleYOffset	
	ldr		r2,	=gameTitle
	ldr		r3,	=0xFFFF00
	bl 		drawText
	
	//args for drawing the live value
	ldr		r0,	=livesNumberXOffset
	ldr		r1,	=wordYoffset
	ldr		r2,	=asciiLives
	ldr		r3,	=0xFFFF00
	bl		drawText

	pop		{pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** drawGameBoard()
** - draws the walls, floors, pellets and check points 
** Param:
** r0 - address of the map to draw
*/
.globl	drawGameBoard
drawGameBoard:
		
	push	{r4-r10,lr}
	
	mapAddr	.req	r4						
	px		.req	r5
	py		.req	r6
	ctr		.req	r7									// 1st counter used in function
	tile	.req	r8						
	gfctr	.req	r9									// ghost flash counter
	
	
	//initialize coordinates 
	mov		px,		#0
	mov		py,		#0
	mov		ctr,	#0
	mov		gfctr,	#0					
	
			
	//get map address
	mov		mapAddr,r0

drawLoop$:

	ldr		r3,	=mapSize								//loop for every tile on the map
	cmp		ctr,	r3								
	bge		doneBoard$							
		

	//if x is greater than map width, reset x to 0 and increment y
	cmp	px,	#mapWidth
	movge	px,	#0
	addge	py,	#1
		
	//get pac man's coords
	ldr		r2,	=pacCoords
	ldmia	r2,	{r0,r1}

	//if pac man's position overlaps with a tile, skip drawing a tile 
	teq		r0, px
	teqeq	r1, py
	beq		incrementCell$

	//get the ghosts coordinates
	ldr		r3,	=ghostCurPos
	mov		gfctr, #0

	//fixes flashing ghosts glitch 
ghostFlashLoop$:
	
	//get ghost's map offset and convert them into their respective x, y coordinates	
	ldr		r0, [r3, gfctr, lsl #2]
	mov		r1, #21
	bl		divideByNumber

	//if the ghosts overlaps with a tile, then skip drawing the tile
	teq		r0,	py
	teqeq	r1,	px
	beq		incrementCell$
	
	add		gfctr,	#1
	teq		gfctr,	#4									//if all the flash fixes for the ghosts are done, terminate loop
	bne		ghostFlashLoop$
		
	//load the tile value
	ldrb	tile,	[mapAddr,ctr]
		
	//args for drawTile
	mov		r0,	px,	lsl #4
	mov		r1,	py,	lsl #4
		
	//if tile is a floor
	cmp		tile,	#0
	ldreq	r2,	=floorTile
	bleq	drawTile
		
	//if tile is a pellet
	cmp		tile,	#1
	ldreq	r2,	=pelletTile
	bleq	drawTile

	//if tile is a wall
	cmp		tile,	#2
	ldreq	r2,	=wallTile
	bleq	drawTile
									
	//if tile is a checkpoint
	cmp		tile,	#3
	ldreq	r2,	=checkpointTile
	bleq	drawTile

incrementCell$:

	add		px,	#1						
	add		ctr,	#1

	bal		drawLoop$
					
doneBoard$:


	.unreq	mapAddr						
	.unreq	px
	.unreq	py
	.unreq	ctr								
	.unreq	tile					
	.unreq	gfctr	
	pop		{r4-r10,pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** updateScreen()
** - redraws the ghosts as well as the game board and texts seen on the screen
**
*/
.globl	updateScreen
updateScreen:

	push	{lr}
	 	
	bl		updateGhosts
						
	ldr		r0,	=currentMap				
	bl		drawGameBoard
	bl		updatePacman
	bl		clearScore
	bl		drawTextScreen

	pop		{pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** clearScore()
** - required to clear the previous score in order to update the score
**
*/
clearScore:			
	push	{r4, lr}
	
	counter	.req	r4
	mov		counter,	 #0
		
clearScoreLoop$:
		
	cmp		counter,	#2
	bge		doneScoreScreen$		
	

	ldr		r0,	=scoreRefreshX	
	mov		r1,	#scoreRefreshOffset			
	add		r0,		counter, lsl #4						//increment the x offset by 16 each time to get each digit			
	ldr		r2,		=floorTile						
	bl		drawTile									//draw floor tile over each digit
		
	add		counter,	#1
	bal		clearScoreLoop$	
		
doneScoreScreen$:

	.unreq	counter
	pop		{r4, pc}
		
/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** drawTile()
** - Draws a 16x16 tile onto the screen given the top left (x,y) coordinates and 16x16 tile ascii address
** Param:
** r0 is px
** r1 is py
** r2 is tile address
*/
.globl drawTile
drawTile:
	
	push	{r4-r9,lr}
	mapAddr	.req	r4
	counter	.req	r5
	x		.req	r6
	y		.req	r7
	i		.req	r8
	j		.req 	r9
	
	mov		counter, #0
	mov		i, 	#0
	mov		j, #0
	
	//save args 
	mov		mapAddr,	r2
	mov 	x, 	r0
	mov		y, 	r1
				
tileLoop$:
	
	cmp	counter, #tileSize								//if each pixel on tile is drawn, terminate loop
	bge	finishLoop$	
	
	//get 	pixel color value
	ldr	r2,	[mapAddr, counter, lsl #1]
		
	//x and y are in r0, r1. r2 contains pixel color.
	//calculated offsets are required in order to center the drawn pixels
	ldr		r0,	=xScreenOffset							
	ldr		r1,	=yScreenOffset
	add		r0,	x
	add		r0,	i
	add		r1,	y
	add		r1,	j

	bl		drawPixel
	
	//if x > 16, move to next row
	cmp		i,	#15
	
	//increment x if x < 16
	add		i,	#1

	//reset x for new row
	movge	i,	#0
	
	//add 1 to y to move down
	addge	j,	#1
	add		counter,	#1
	
	bal		tileLoop$
	
finishLoop$:
	
	.unreq	mapAddr
	.unreq	counter
	.unreq	x
	.unreq	y
	.unreq	i
	.unreq	j
	pop	{r4-r9,pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** updatePacman()
** - Updates pac-man on the screen by using his offset position stored in memory
*/
.globl updatePacman
updatePacman:

	push {r4-r5, lr}
		
	//get pac man's init position
	ldr		r4,	=pacCoords
	ldmia	r4,	{r4,r5}

	//pass pac man coords as args
	mov		r0,	r4, lsl #4
	mov		r1,	r5, lsl #4

	ldr		r2,	=pac_man
	bl		drawTile
	pop 	{r4-r5, pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** updateGhosts()
** - Updates the ghosts on the screen by using the ghosts offsets stored in memory
*/
.globl updateGhosts
updateGhosts:
		
	push	{r4-r6, lr}
	
	counter .req r5
	mov		counter,	#0

updateLoop$:
		
	ldr		r4, =ghostCurPos
	ldr		r4, [r4, counter, lsl #2]
		
	mov		r0, r4
	mov		r1, #21
	bl		divideByNumber

	//set the args for drawing the ghosts
	mov		r2, r1, lsl #4
	mov		r1, r0, lsl #4
	mov		r0, r2
	
	//if ghost is blinky
	cmp		counter,	#0
	ldreq	r2, =blinky
	
	//if ghost is inky
	cmp		counter,	#1
	ldreq	r2, =inky

	//if ghost is pinky
	cmp		counter,	#2
	ldreq	r2, =pinky

	//if ghost is clyde
	cmp		counter,	#3
	ldreq	r2, =clyde	
		
	bl		drawTile

	add		counter,	#1
	teq		counter, #4
	bne 	updateLoop$

	.unreq  counter
	pop		{r4-r6, pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** initCharacters()
** - draws the ghosts and pac man in their intial states
*/
.globl initCharacters
initCharacters:
	
	push {r4-r9, lr}
		
	counter	.req	r7
	//get pac_mans init position
	ldr		r4,	=pacStartCoords
	ldmia	r4,	{r4,r5}

	//pass pac man coords as args
	mov		r0,	r4, lsl #4
	mov		r1,	r5, lsl #4

	ldr		r2,	=pac_man
	bl		drawTile
		
	ldr		r4,	=ghostCoordinates
	mov 	counter, #0
		
	//next draw the ghosts
ghostDrawLoop$:

	ldr		r5,	[r4, counter,lsl #2]
	mov		r3,	counter
	add		r3,	#1
	ldr		r6,	[r4, r3, lsl #2]
		
	//pass pac man coords as args
	mov		r0,	r5, lsl #4
	mov		r1,	r6, lsl #4
	
	//the first ghost to draw is blinky
	cmp		counter, #0
	ldreq	r2,	=blinky

	cmp		counter, #2
	ldreq	r2,	=inky

	cmp		counter, #4
	ldreq	r2,	=pinky
	
	cmp		counter, #6
	ldreq	r2,	=clyde

	bl		drawTile
	
	add		counter, #2
	teq		counter, #8
	bne		ghostDrawLoop$
	
	.unreq	counter
	pop 	{r4-r9, pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** updateScoreOnScreen()
** - draws the 3-digit score onto the screen
*/
.globl updateScoreOnScreen
updateScoreOnScreen:

	push 	{r4-r9, lr}

	//preserve the color arg
	mov		r5,  r0
	
	//get the current score
	ldr		r0,	=score
	ldr		r0,	[r0]

	//divide the score by 10. Remainder gives last digit
	mov		r1,  #10
	bl	divideByNumber
	mov		r6,	r1

	//second division gives middle digit as remainder and first digit as quotient
	mov		r1,  #10
	bl	divideByNumber
	mov		r7,	r1
	mov		r8, r0

	//convert to ascii
	add		r6,	#48
	add		r7,	#48
	add		r8,	#48

	//store the digits in memory (4th digit is a 0 for loop termination)
	ldr		r9,	=scoreDigits
	strb 	r8, [r9]
	strb 	r7, [r9,#1]
	strb 	r6, [r9,#2]

	//set the args for drawing the score
	mov		r0,	#scoreNum1Xoffset
	mov		r1,	#wordYoffset
	ldr		r9,	=scoreDigits
	mov		r2,	r9
	mov		r3,	 r5
	bl		drawText

	pop {r4-r9, pc}











