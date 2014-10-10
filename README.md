Modify tiles.coffee between "Your code goes here" comments to tile the board
with the given tiles, so that all tiles are used.

- The board is an array of arrays of size x size, with a number or null in each cell.

- A tile is a group of horizontally and vertically connected cells on the board, which each
have the same number.

- Each entry is a number from 0 to one less than the number of tiles.

Running tiles.coffee, gives this:

    Let's try tiling a 3 x 3 board with 3 tiles:

    Tiles:

    0: 0 0 0 
    1: 0 0 0 
    2: . . . 

    0: 1 . . 
    1: . . . 
    2: . . . 

    0: 2 2 . 
    1: . . . 
    2: . . . 

    Original tiling:

    0: 1 2 2 
    1: 0 0 0 
    2: 0 0 0 

    Your tiling:

    0: . . . 
    1: . . . 
    2: . . . 

    Your solution is not correct!

    Solved?

    (3x3): No!
    (4x4): No!
    (5x5): No!
    (6x6): No!

Modify the code, so that below "Your tiling:", a board is shown that used the tiles provided to tile the board.
