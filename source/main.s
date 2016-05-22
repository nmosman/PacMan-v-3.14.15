/* main. s
* This file contains the game loop which makes calls to all other necessary functions in order to run the game!
*/

.section    .init
.global     _start
_start:
    b       main

.section .text
/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** main()
** - calls all the necessary functions including the game loop in order to play the game 
**
*/
.globl main
main:

   	mov		sp, #0x8000
	bl		EnableJTAG
	bl		initializeGame
	bal		gameLoop

/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
**********************************************************************************************************************************************
** game_loop()
** - main loop of the game that makes calls to the central functions that make the game playable (game logic, graphics)
**
*/
.globl gameLoop	
gameLoop:
	
	//required for optimizing game speed 
	bl		saveCurrentTime

	//check for either winning or losing game
	bl 		checkGameState

	//get player input
	bl 		getSNESInput 

	//process the player and the ai's moves 
	bl 		movePacMan

	//process collision before ghost moves
	bl		collisionCheck
	bl		processGhostsMove

	//update and draw grafiques 
	bl		updateScreen
	bl		delayGame
	bal 	gameLoop
		

