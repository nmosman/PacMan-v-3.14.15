/* image.s
** This file contains all the ascii maps for each image/tile used on the screen
*/

/////////////////////////
//  Image Ascii Maps   //										   
/////////////////////////


.section .data

//pac-man's ascii value 
.global pac_man
pac_man:
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\340\377\340\377\340\377\340\377\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\0\0\0\0\0\0\0\0\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\0\0\0\0\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\0\0\0\0\0\0\0\0\0\0\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\0\0\0\0\0\0\0\0\0\0\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\0\0\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\0\0\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\0\0\0\0\0\0\0\0\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\340\377\340\377\340\377\340\377\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0"


//ghosts ascii value 
.global blinky
blinky:
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0A\310A\310A\310A\310\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0A\310A\310A\310A\310A\310A\310A\310A\310"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0A\310A\310A\310A\310A\310A\310"
.ascii "A\310A\310A\310A\310\0\0\0\0\0\0\0\0\0\0A\310\276\367\276\367"
.ascii "A\310A\310A\310A\310\276\367\276\367A\310A\310A\310\0\0\0\0"
.ascii "\0\0\0\0\276\367\276\367\276\367\276\367A\310A\310\276\367\276\367"
.ascii "\276\367\276\367A\310A\310\0\0\0\0\0\0\0\0_\1_\1\276\367"
.ascii "\276\367A\310A\310_\1_\1\276\367\276\367A\310A\310\0\0\0\0"
.ascii "\0\0A\310_\1_\1\276\367\276\367A\310A\310_\1_\1\276\367\276\367"
.ascii "A\310A\310A\310\0\0\0\0A\310A\310\276\367\276\367A\310A\310"
.ascii "A\310A\310\276\367\276\367A\310A\310A\310A\310\0\0\0\0A\310"
.ascii "A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310"
.ascii "A\310\0\0\0\0A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310"
.ascii "A\310A\310A\310A\310\0\0\0\0A\310A\310A\310A\310A\310A\310"
.ascii "A\310A\310A\310A\310A\310A\310A\310A\310\0\0\0\0A\310A\310"
.ascii "A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310"
.ascii "\0\0\0\0A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310A\310"
.ascii "A\310A\310A\310\0\0\0\0A\310A\310A\310A\310A\310A\310A\310"
.ascii "A\310A\310A\310A\310A\310A\310A\310\0\0\0\0A\310A\310\0\0A\310"
.ascii "A\310A\310\0\0\0\0A\310A\310A\310\0\0A\310A\310\0\0\0\0A\310"
.ascii "\0\0\0\0\0\0A\310A\310\0\0\0\0A\310A\310\0\0\0\0\0\0A\310"
.ascii "\0\0"

.global pinky
pinky:

.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\230\373\230\373\230\373\230\373\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\0\0\0\0\0\0\230\373\276\367"
.ascii "\276\367\230\373\230\373\230\373\230\373\276\367\276\367\230\373"
.ascii "\230\373\230\373\0\0\0\0\0\0\0\0\276\367\276\367\276\367"
.ascii "\276\367\230\373\230\373\276\367\276\367\276\367\276\367\230\373"
.ascii "\230\373\0\0\0\0\0\0\0\0_\1_\1\276\367\276\367\230\373"
.ascii "\230\373_\1_\1\276\367\276\367\230\373\230\373\0\0\0\0\0\0\230\373"
.ascii "_\1_\1\276\367\276\367\230\373\230\373_\1_\1\276\367\276\367"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\276\367"
.ascii "\276\367\230\373\230\373\230\373\230\373\276\367\276\367\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\230\373\230\373\230\373\230\373\230\373"
.ascii "\230\373\230\373\230\373\0\0\0\0\230\373\230\373\0\0\230\373"
.ascii "\230\373\230\373\0\0\0\0\230\373\230\373\230\373\0\0\230\373"
.ascii "\230\373\0\0\0\0\230\373\0\0\0\0\0\0\230\373\230\373\0\0"
.ascii "\0\0\230\373\230\373\0\0\0\0\0\0\230\373\0\0"


.globl inky
inky:
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\234\17\234\17\234\17\234\17\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\0\0\0\0\0\0\0\0\0\0\0\0\0\0\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\0\0\0\0\0\0\0\0\0\0\234\17\276\367\276\367\234\17\234\17"
.ascii "\234\17\234\17\276\367\276\367\234\17\234\17\234\17\0\0\0\0"
.ascii "\0\0\0\0\276\367\276\367\276\367\276\367\234\17\234\17\276\367"
.ascii "\276\367\276\367\276\367\234\17\234\17\0\0\0\0\0\0\0\0_\1_\1"
.ascii "\276\367\276\367\234\17\234\17_\1_\1\276\367\276\367\234\17"
.ascii "\234\17\0\0\0\0\0\0\234\17_\1_\1\276\367\276\367\234\17\234\17"
.ascii "_\1_\1\276\367\276\367\234\17\234\17\234\17\0\0\0\0\234\17"
.ascii "\234\17\276\367\276\367\234\17\234\17\234\17\234\17\276\367"
.ascii "\276\367\234\17\234\17\234\17\234\17\0\0\0\0\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\0\0\0\0\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\0\0\0\0\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\0\0\0\0"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\0\0\0\0\234\17\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\0\0\0\0\234\17\234\17\234\17\234\17"
.ascii "\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17\234\17"
.ascii "\234\17\0\0\0\0\234\17\234\17\0\0\234\17\234\17\234\17\0\0"
.ascii "\0\0\234\17\234\17\234\17\0\0\234\17\234\17\0\0\0\0\234\17"
.ascii "\0\0\0\0\0\0\234\17\234\17\0\0\0\0\234\17\234\17\0\0\0\0\0\0"
.ascii "\234\17\0\0"


.globl clyde
clyde:

.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\3\375\3\375\3\375\3\375\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\3\375\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\375\3\375\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\0\0\0\0\0\0\0\0\0\0"
.ascii "\3\375\276\367\276\367\3\375\3\375\3\375\3\375\276\367\276\367"
.ascii "\3\375\3\375\3\375\0\0\0\0\0\0\0\0\276\367\276\367\276\367"
.ascii "\276\367\3\375\3\375\276\367\276\367\276\367\276\367\3\375"
.ascii "\3\375\0\0\0\0\0\0\0\0_\1_\1\276\367\276\367\3\375\3\375_\1_\1"
.ascii "\276\367\276\367\3\375\3\375\0\0\0\0\0\0\3\375_\1_\1\276\367"
.ascii "\276\367\3\375\3\375_\1_\1\276\367\276\367\3\375\3\375\3\375"
.ascii "\0\0\0\0\3\375\3\375\276\367\276\367\3\375\3\375\3\375\3\375"
.ascii "\276\367\276\367\3\375\3\375\3\375\3\375\0\0\0\0\3\375\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\0\0\0\0\3\375\3\375\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\0\0\0\0\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\3\375\0\0\0\0\3\375\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\0\0\0\0\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\3\375\0\0\0\0\3\375\3\375\3\375\3\375\3\375"
.ascii "\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\3\375\0\0\0\0"
.ascii "\3\375\3\375\0\0\3\375\3\375\3\375\0\0\0\0\3\375\3\375\3\375"
.ascii "\0\0\3\375\3\375\0\0\0\0\3\375\0\0\0\0\0\0\3\375\3\375\0\0"
.ascii "\0\0\3\375\3\375\0\0\0\0\0\0\3\375\0\0"



//map tiles
.global checkpointTile
checkpointTile:
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0 c@\306\0\347\340\377\340\377\340\377\340\377"
.ascii "\0\347@\306 c\0\0\0\0\0\0\0\0\0\0 c c@\306\0\347\340\377\340\377"
.ascii "\340\377\340\377\0\347@\306 c c\0\0\0\0\0\0\0\0@\306@\306"
.ascii "@\306\340\377\340\377\340\377\340\377\340\377\340\377@\306"
.ascii "@\306@\306\0\0\0\0\0\0\0\0\0\347\0\347\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\0\347\0\347\0\0"
.ascii "\0\0\0\0\0\0\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\0\0\0\0\0\0"
.ascii "\0\0\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\0\0\0\0\0\0\0\0\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\0\0\0\0\0\0\0\0\340\377\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377\0\0\0\0\0\0\0\0\0\347\0\347\340\377"
.ascii "\340\377\340\377\340\377\340\377\340\377\340\377\340\377\0\347"
.ascii "\0\347\0\0\0\0\0\0\0\0@\306@\306@\306\340\377\340\377\340\377"
.ascii "\340\377\340\377\340\377@\306@\306@\306\0\0\0\0\0\0\0\0 c"
.ascii " c@\306\0\347\340\377\340\377\340\377\340\377\0\347@\306 c c"
.ascii "\0\0\0\0\0\0\0\0\0\0 c@\306\0\347\340\377\340\377\340\377\340\377"
.ascii "\0\347@\306 c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"

.global pelletTile
pelletTile:

.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 c\340\377\340\377"
.ascii " c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\340\377"
.ascii "\340\377\340\377\340\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\340\377\340\377\340\377\340\377\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 c\340\377\340\377 c\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"

.globl wallTile
wallTile:
.ascii "\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0"
.ascii "\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0"
.ascii "\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\37\0\37\0\37\0\37\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\37\0\37\0\37\0\37\0"
.ascii "\0\0\0\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\0\0\0\0"
.ascii "\37\0\37\0\37\0\37\0\0\0\0\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0"
.ascii "\37\0\0\0\0\0\37\0\37\0\37\0\37\0\0\0\0\0\37\0\37\0\0\0\0\0"
.ascii "\0\0\0\0\37\0\37\0\0\0\0\0\37\0\37\0\37\0\37\0\0\0\0\0\37\0"
.ascii "\37\0\0\0\0\0\0\0\0\0\37\0\37\0\0\0\0\0\37\0\37\0\37\0\37\0"
.ascii "\0\0\0\0\37\0\37\0\0\0\0\0\0\0\0\0\37\0\37\0\0\0\0\0\37\0\37\0"
.ascii "\37\0\37\0\0\0\0\0\37\0\37\0\0\0\0\0\0\0\0\0\37\0\37\0\0\0"
.ascii "\0\0\37\0\37\0\37\0\37\0\0\0\0\0\37\0\37\0\37\0\37\0\37\0\37\0"
.ascii "\37\0\37\0\0\0\0\0\37\0\37\0\37\0\37\0\0\0\0\0\37\0\37\0\37\0"
.ascii "\37\0\37\0\37\0\37\0\37\0\0\0\0\0\37\0\37\0\37\0\37\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\37\0\37\0\37\0\37\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\37\0\37\0"
.ascii "\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0"
.ascii "\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0"
.ascii "\37\0\37\0\37\0\37\0\37\0\37\0\37\0\37\0"

.globl floorTile
floorTile:
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
.ascii ""
