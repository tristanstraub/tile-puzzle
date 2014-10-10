Modify tiles.coffee between "Your code goes here" comments to tile the board
with the given tiles, so that all tiles are used.

- The board is an array of arrays of size x size, with a number or null in each cell.

- A tile is a group of horizontally and vertically connected cells on the board, which each
have the same number.

- Each entry is a number from 0 to one less than the number of tiles.

Running tiles.coffee, gives this:

    Tiles:

    0: 0 . . . 
    1: 0 . . . 
    2: 0 0 . . 
    3: . 0 . . 

    0: 1 . . . 
    1: . . . . 
    2: . . . . 
    3: . . . . 

    0: 2 2 2 . 
    1: 2 2 2 . 
    2: . 2 . . 
    3: . . . . 

    0: . 3 . . 
    1: 3 3 . . 
    2: . . . . 
    3: . . . . 

    Original tiling:

    0: 0 2 2 2 
    1: 0 2 2 2 
    2: 0 0 2 3 
    3: 1 0 3 3 

    Your tiling:

    0: . . . . 
    1: . . . . 
    2: . . . . 
    3: . . . . 

    Your solution is not correct!

Modify the code, so that below "Your tiling:", a board is shown that used the tiles provided to tile the board.
