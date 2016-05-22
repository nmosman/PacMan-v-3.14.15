/* player.s 
** This file is primarily responsible for the logic of the player's input
*/


///////////////////
//   Constants	 //										   
///////////////////


//Button Masks
//////////////
start 	= 0x8
up 		= 0x10
down 	= 0x20
left	= 0x40
right	= 0x80


//Offsets and Bounds
////////////////////
xCoordOffset = 1
yCoordOffset = 1
vertMovement = 21
horiMovement = 1
mapLowerBound = 22
mapUpperBound = 462 

//Tile Types
////////////////////
checkPointTileType = 3
wallTileType = 2
floorTileType = 0
pelletTileType = 1

.section .text

//move function deals with player input and it's validity.
/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////**********************************************************************************************************************************************
** movePacMan()
** - responsible for moving pac man on the map based on the input from the user
** Parameters:
** r0 - sampled buttons register from the SNES controller
*/
.globl movePacMan
movePacMan:
	
	push    	{r4-r10, lr}
		
	tmp			.req	r6
	pacPos		.req	r7
	pacX		.req	r8
	pacY		.req	r9
	buttons 	.req 	r10
	
	//save the input buttons.
	mov			buttons,	r0
	
	//get map address
	ldr     	r4, 	=currentMap

	//if start button is pressed restart the game 
	tst			buttons,#start
	ldreq		r0, 	=resetMap
	beq 		resetData
	
	//load pac mans current position offset
	ldr			r1,  	=pacCurPos
	ldr     	r2, 	[r1]

	//get pac mans x and y coordinates
	ldr			r7,		=pacCoords
	ldmia		r7,		{pacX,pacY}
	
	//if up is pressed, check if moving up is valid
	tst 		buttons, #up
	subeq   	r2, 	#vertMovement
	subeq   	pacY, 	#yCoordOffset
	beq			try_move$
	
	//if down is pressed, check if moving down is valid
	tst 		buttons,#down
	addeq   	r2, 	#vertMovement
	addeq   	pacY, 	#yCoordOffset
	beq			try_move$

	//if left is pressed, check if moving left is valid
	tst 		buttons,#left
	subeq   	r2, 	#horiMovement
	subeq   	pacX, 	#xCoordOffset
	beq			try_move$
	
	//if right is pressed, check if moving right is valid
	tst 		buttons,#right
	addeq   	r2, 	#horiMovement
	addeq   	pacX,	#xCoordOffset
	
try_move$:
	
	//save pac man's position offset
	mov			tmp,	r2
	
	//pass the position as an arg
	mov			r0,		r2
	
	//check if move is valid
	bl 			validMove
	
	//if move was invalid (ie. valid move returns 0), return to game loop.
	cmp 		r0, 	#0
	popeq 		{r4-r10, pc}
	
	//get pac mans position
	ldr			r2, 	=pacCurPos
	
	//if the move was valid, store the updated current position	
	str   		tmp, 	[r2]

	//update the coordinates of pac man	
	ldr			r2,		=pacCoords
	stmia		r2,		{pacX,pacY}

	//check to see if the position is a checkpoint, if yes branch to saveMap and change the checkpoint to a floor tile
	ldrb		r0, 	[r4, tmp]
	cmp  		r0, 	#checkPointTileType
	moveq		r3,		#0
	streqb 		r3, 	[r4, tmp]
	bleq 		saveMap
	
	//if the new position is at a pellet, branch to pellet-update
	ldrb    	r0, 	[r4, tmp]
	cmp			r0, 	#1
	bleq		pelletUpdate

	.unreq	buttons		
	.unreq	pacPos		
	.unreq	pacX		
	.unreq	pacY	

	//return
	pop 	{r4-r10, pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** saveMap()
** - saves the current map state
*/
saveMap:

	push	{r4,r5}

	// save pacmans current position at the checkpoint				
	ldr		r1,		=curCheckPoint
	ldr		r2,		=pacCurPos
	ldr 	r2,	 	[r2]
	str		r2, 	[r1]
	ldr		r2,		=pacCoords
	ldmia	r2,		{r0,r1}
	ldr		r2,		=checkPointCoords
	stmia	r2,		{r0,r1}

	//save pellet count before hitting checkpoint
	ldr		r4,		=pellets
	ldr		r4,		[r4]
	ldr		r5,		=savedPellets
	str		r4,		[r5]

	//put current score into saved score
	ldr		r4,		=savedScore
	ldr		r5,		=score
	ldr		r5,		[r5]
	str		r5,		[r4]
	
	//checkpoint counter, and is is the map size to loop throught map
	cpctr	.req	r0
	ldr		r1,		=mapUpperBound
	
	// load the address of currentMap and checkPointMap inorder to save the map	
	ldr		r3,		=currentMap
	ldr		r4,		=checkPointMap

	// save the entire map into checkPointMap r3= current map, r4= checkPointMap
save_Loop$:

	cmp		cpctr,	r1
	bge		finishSave$
	
	ldrb	r5,	[r3,cpctr]
	strb	r5,	[r4,cpctr]
	add		cpctr,  #1
	
	bal		save_Loop$

//return once map is saved
finishSave$:

	pop		{r4,r5}
	mov		pc,	lr 		

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** pelletUpdate()
** - updates the pellets into floor tiles and increments the score subsequently
*/
pelletUpdate:
	
	push	{r4-r7}

	//get map address	
	ldr		r4,	=currentMap
	
	//decrement the pellet
	ldr 	r2, =pellets
	ldr		r3, [r2]
	sub		r3, #1
	
	//if pellets hit zero, set the win flag
	cmp		r3,	#0
	ldreq	r5,  =winFlag
	moveq	r7,	#1
	streq	r7,   [r5]
	str		r3, [r2]
	
	//change the pellet tile to a floor tile
	mov		r3,	#0
	strb 	r3, [r4, tmp]
	
	//increment the score
	ldr 	r2, =score
	ldr		r3, [r2]
	add		r3, #1			
	str		r3, [r2]
	
	pop		{r4-r7}
	//return
	mov 	pc, lr	

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** validMove() 
** - checks to see if the move is valid
** Params:
** r0 - updated position of pac man 
** Returns:
** r0 - boolean of the made move (returns 1 if move was valid, 0 otherwise)
*/
.globl validMove
validMove:

	//if player is out of bounds, return false (#0)
	cmp     r0, #mapLowerBound
	movlt   r0, #0   
	movlt   pc, lr

	//if player is out of bounds, return false (#0)
	ldr		r3,	=mapUpperBound
	cmp     r0, r3
	movgt   r0, #0
	movgt   pc, lr 
	
	//get current tile value at the current position
	ldr   	r2, =currentMap
	ldrb  	r3, [r2, r0]
	
	//if new position is at a wall, return false (#0)	
	cmp     r3, #wallTileType
	moveq   r0, #0   
	moveq   pc, lr
	
	//move was succesful, return true
	mov 	r0, #1
	mov     pc, lr

.section .data

//////////////////////////////
//   Pac Man's Variables	//										   
//////////////////////////////

.globl	pacStartPos
pacStartPos:
	.int    346

.globl	pacCurPos
pacCurPos:
	.int    346

.globl  curCheckPoint
curCheckPoint:
	.int	346

.globl checkPointCoords
checkPointCoords:
	.int	10,	16

.globl pacCoords
pacCoords:
	.int	10, 16

.globl	pacStartCoords
pacStartCoords:
	.int	10, 16


			



