/* ghost.s
** This file contains most of the logic for the movement of the ghosts
*/

///////////////////
//   Constants	 //										   
///////////////////


//Offsets and Bounds
////////////////////
horiMovement = 1
vertMovement = 21
mapMinBound	 =22 
mapMaxBound	 =461

//Other Constants
/////////////////
wall        = 2
mask 		= 0x3


.section .text 

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** moveGhosts()
** - main function of this file that moves each ghost on the map
**
*/
.globl moveGhosts
moveGhosts:

	push 		{r4-r6,lr}
	counter 	.req r4
	tempGhostMove			.req r5	
	tempGhostMove2 		.req r6
	mov 		counter, #0

//top of the loop
next_ghost$:
	
	//loop through 4 ghosts
	cmp     counter, #4
	popge	{r4-r6,pc}

	//get ghost's position
	ldr 	r2,  =ghostCurPos
	ldr		tempGhostMove2, [r2, counter, lsl #2]
	
	//pass in ghost position as an arg, to see if ghost has a valid move, return 0 or 1 in r0	
	mov		r0, tempGhostMove2
	bl 		canGhostMove
	
	//check if valid move exists for the ghost, if 0 was returned no valid move if 1 valid move exist
	cmp 	r0, #0
	beq 	increment$


	// there exist a valid move for ghost try to generate it.
move_loop$:	
	mov		r0,		tempGhostMove2
	bl 		moveGenerator									//generate a move for ghost, return move in r0
	mov		tempGhostMove,	r0
	bl 		validGhostMove										//check if move is valid, return 0 for invalid
	cmp		r0, 	#0
	beq 	move_loop$										//loop again until you find valid move					

	ldr 	r2,  	=ghostCurPos
	str		tempGhostMove,	[r2, counter, lsl #2]			//store the valid move


//increment counter, go back to the top, and try and move the next ghost	
increment$:
	add		counter, #1
	bal 	next_ghost$

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** moveGenerator()
** - generates a random move for each ghost based on the last two bits of the clock
** Params:
** r0 - ghost offset position
** Returns:
** r0 - randomly generated move for the ghost
*/
moveGenerator:

	//clo address	
	ldr		r2, =0x20003004 
	ldr 	r2, [r2]

	//masks out the last two bits
	and 	r2, #mask		
	
	//if clock gives 00, move ghost up
	cmp		r2, #0
	subeq	r0, r0, #vertMovement
	
	//if clock gives 01, move ghost down
	cmp		r2, #1
	addeq	r0, r0, #vertMovement

	//if clock gives 10, move ghost left
	cmp		r2, #2
	subeq	r0, r0, #horiMovement

	//if clock gives 11, move ghost right
	cmp		r2, #3
	addeq	r0, r0, #horiMovement

	//return
	mov 	pc,  lr
	
/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** canGhostMove()
** - determines whether there is at least one valid move for the ghost
** Params:
** r0 - ghost offset position
** Returns:
** r0 - boolean value of whether the ghost can move (false for no possible moves)
*/
canGhostMove:

	push	{r4-r8,lr}
	
	//store the ghost position in r8	
	mov		r8,	r0
	//invalid move counter
	mov 	r4, #0
	
	//get map address
	ldr   	r5, =currentMap
	
	//check above to see if there exits any collision wall or ghost
	sub    	r3, r8, #vertMovement
	mov		r0,	r3
	ldrb    r3, [r5, r3]
	cmp    	r3, #wall 
	moveq  	r6, #1												// if there is wall move 1 into r6 else 0
	movne  	r6, #0
	bl 		ghostCollision										//check collision against other ghost, return 1 for true else 0
	orr		r7, r6,  r0											// or the result of r6 and r0 and add to r4 inorder
	add		r4, r7												// to check if ghost can move, if r4= 4 ghost cant move

	//check below to see if there exits any collision wall or ghost
	add    	r3, r8, #vertMovement
	mov		r0,	r3
	ldrb    r3, [r5, r3]
	cmp    	r3, #wall 
	moveq  	r6, #1												// if there is wall move 1 into r6 else 0
	movne  	r6, #0	
	bl 	 	ghostCollision										//check collision against other ghost, return 1 for true else 0
	orr 	r7, r6,  r0											// or the result of r6 and r0 and add to r4 inorder
	add		r4, r7												// to check if ghost can move, if r4= 4 ghost cant move

	//check to the left to see if there exits any collision wall or ghost
	sub    	r3, r8, #horiMovement
	mov		r0,	r3
	ldrb    r3, [r5, r3]
	cmp    	r3, #wall 
	moveq  	r6, #1												// if there is wall move 1 into r6 else 0
	movne  	r6, #0
	bl 		ghostCollision										//check collision against other ghost, return 1 for true else 0
	orr 	r7, r6,  r0											// or the result of r6 and r0 and add to r4 inorder
	add		r4, r7												// to check if ghost can move, if r4= 4 ghost cant move

	//check to the right to see if there exits any collision wall or ghost
	add    	r3, r8, #horiMovement
	mov		r0,	r3
	ldrb    r3, [r5, r3]
	cmp    	r3, #wall
	moveq  	r6, #1												// if there is wall move 1 into r6 else 0
	movne  	r6, #0	
	bl 		ghostCollision										//check collision against other ghost, return 1 for true else 0
	orr 	r7, r6,  r0											// or the result of r6 and r0 and aaddtt to r4 inorder
	add		r4, r7												// to check if ghost can move, if r4= 4 ghost cant move

	//if r4 = 4 there is no valid move for ghost, return 0 in r0
	cmp    r4, #4
	moveq  r0, #0
	
	//otherwise, a valid move exists, return 1 in r0
	movne  r0, #1
	
	//return
	pop 	{r4-r8,pc}

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** ghostCollision()
** checks if a given ghost collides with any of the other ghosts on the map
** Params:
** r0 - ghost offset position
** Returns:
** r0 - returns true if there is a collision, false otherwise 
**
*/
ghostCollision:
	push	{r4-r8}
	mov		r5,	r0												//save ghost position in r5
	counter2 .req r2
	mov		counter2, #0
	
ghost_loop$:

	cmp		counter2,	#4										//counter to loop throught all ghosts
	popge	{r4-r8}												//return once all ghost are looped
	movge	pc,lr
	ldr 	r4, =ghostCurPos								
	ldr 	r1, [r4, counter2, lsl #2]
	
	//if two ghosts share a position, return 1 else 0
	cmp		r5,  r1
	moveq	r0, #1
	popeq	{r4-r8}
	moveq	pc,	lr
	movne	r0, #0
	
	//increase counter and move on to the next ghost	
	add		counter2, #1
	bal		ghost_loop$

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** validGhostMove()
** - checks to see if the generated ghost move is valid (ie. is ghost moving out the map, at a wall, etc.)
** Params:
** r0 - randomly generated move for the ghost
** Returns:
** r0 - true if the move is valid, false otherwise
*/
validGhostMove:

	//if ghost is out of bounds, return false (#0)
	cmp     r0, #mapMinBound
	movlt   r0, #0   
	movlt   pc, lr

	//if ghost is out of bounds, return false (#0)
	ldr		r2,	=mapMaxBound
	cmp     r0, r2
	movgt   r0, #0
	movgt   pc, lr 
	
	//get current tile value at the current position
	ldr   	r2, =currentMap
	ldrb   	r3, [r2, r0]
	
	//if new position is at a wall return 0	
	cmp     r3, #wall
	moveq   r0, #0   
	moveq   pc, lr

	push	{lr}
	
	//check for other surrounding ghosts
	bl		ghostCollision
	eor		r0, #1
	//move was successful
	//return
	pop		{pc}

.section .data 

///////////////////////////
//   Ghost Variables	 //										   
///////////////////////////

//the starting position of the ghosts
.globl ghostStartPos
ghostStartPos:
	.int    199, 219, 220, 221

//the ghost coordinates x, y
.globl ghostCoordinates
ghostCoordinates:
	.int	10, 9  
	.int	9, 10
	.int	10, 10
	.int	11, 10

//the ghost starting coordinates x,y
.globl ghostStartCoordinates
ghostStartCoordinates:
	.int	10, 9
	.int	9, 10
	.int	10, 10
	.int	11, 10

//ghost current position
.globl ghostCurPos
ghostCurPos:
	.int    199, 219, 220, 221


