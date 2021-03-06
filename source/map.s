/* map.s
** This file contains the map used to shuffle between diffrent saving and loading of game maps.
*/

.section	.init
.section 	.data

//Legend
///////////////////
// 0 - Floor
// 1 - Pellet
// 2 - Wall
// 3 - Checkpoint						
///////////////////
							
							
//this is the current map, it will  be updated during game play.					
.globl currentMap
currentMap:
.byte 	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2						
.byte	2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2
.byte	2,3,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,3,2
.byte	2,1,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,1,2
.byte	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2
.byte	2,1,2,2,2,1,2,1,2,2,2,2,2,1,2,1,2,2,2,1,2					
.byte	2,1,1,1,1,1,2,1,1,1,2,1,1,1,2,1,1,1,1,1,2
.byte	2,2,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,0,0,0,0,0,0,2,1,2,2,2,2,2   
.byte	2,2,2,2,2,1,2,0,2,2,0,2,2,0,2,1,2,2,2,2,2
.byte	2,0,0,0,0,1,0,0,2,0,0,0,2,0,0,1,0,0,0,0,2
.byte	2,2,2,2,2,1,2,0,2,2,2,2,2,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,0,0,0,0,0,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,2,2,2,2,2,0,2,1,2,2,2,2,2
.byte	2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2
.byte	2,1,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,1,2				
.byte	2,3,1,1,2,1,1,1,1,1,0,1,1,1,1,1,2,1,1,3,2
.byte	2,2,2,1,2,1,2,1,2,2,2,2,2,1,2,1,2,1,2,2,2
.byte	2,1,1,1,1,1,2,1,1,1,2,1,1,1,2,1,1,1,1,1,2
.byte	2,1,2,2,2,2,2,2,2,1,2,1,2,2,2,2,2,2,2,1,2
.byte	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2
.byte	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2

// this is the intitial map, will be redraw at the begening of every game.
.globl resetMap
resetMap:
.byte 	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
.byte	2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2
.byte	2,3,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,3,2
.byte	2,1,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,1,2
.byte	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2
.byte	2,1,2,2,2,1,2,1,2,2,2,2,2,1,2,1,2,2,2,1,2
.byte	2,1,1,1,1,1,2,1,1,1,2,1,1,1,2,1,1,1,1,1,2
.byte	2,2,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,0,0,0,0,0,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,2,2,0,2,2,0,2,1,2,2,2,2,2
.byte	2,0,0,0,0,1,0,0,2,0,0,0,2,0,0,1,0,0,0,0,2
.byte	2,2,2,2,2,1,2,0,2,2,2,2,2,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,0,0,0,0,0,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,2,2,2,2,2,0,2,1,2,2,2,2,2
.byte	2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2
.byte	2,1,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,1,2
.byte	2,3,1,1,2,1,1,1,1,1,0,1,1,1,1,1,2,1,1,3,2
.byte	2,2,2,1,2,1,2,1,2,2,2,2,2,1,2,1,2,1,2,2,2
.byte	2,1,1,1,1,1,2,1,1,1,2,1,1,1,2,1,1,1,1,1,2
.byte	2,1,2,2,2,2,2,2,2,1,2,1,2,2,2,2,2,2,2,1,2
.byte	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2
.byte	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2



//this map is draw if you have a checkpoint to return to.
.globl checkPointMap
checkPointMap:
.byte 	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
.byte	2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2
.byte	2,3,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,3,2
.byte	2,1,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,1,2
.byte	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2
.byte	2,1,2,2,2,1,2,1,2,2,2,2,2,1,2,1,2,2,2,1,2
.byte	2,1,1,1,1,1,2,1,1,1,2,1,1,1,2,1,1,1,1,1,2
.byte	2,2,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,0,0,0,0,0,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,2,2,0,2,2,0,2,1,2,2,2,2,2
.byte	2,0,0,0,0,1,0,0,2,0,0,0,2,0,0,1,0,0,0,0,2
.byte	2,2,2,2,2,1,2,0,2,2,2,2,2,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,0,0,0,0,0,0,2,1,2,2,2,2,2
.byte	2,2,2,2,2,1,2,0,2,2,2,2,2,0,2,1,2,2,2,2,2
.byte	2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2
.byte	2,1,2,2,2,1,2,2,2,1,2,1,2,2,2,1,2,2,2,1,2
.byte	2,3,1,1,2,1,1,1,1,1,0,1,1,1,1,1,2,1,1,3,2
.byte	2,2,2,1,2,1,2,1,2,2,2,2,2,1,2,1,2,1,2,2,2
.byte	2,1,1,1,1,1,2,1,1,1,2,1,1,1,2,1,1,1,1,1,2
.byte	2,1,2,2,2,2,2,2,2,1,2,1,2,2,2,2,2,2,2,1,2
.byte	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2
.byte	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2


