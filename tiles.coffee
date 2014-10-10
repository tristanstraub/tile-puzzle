_ = require 'lodash'


getEmptyBoard = (size) ->
  rows = []
  for i in [0...size]
    row = []
    rows.push row
    for j in [0...size]
      row.push null
  return rows

getBoardSize = (board) ->
  return board.length

cloneBoard = (board) ->
  size = getBoardSize board
  empty = getEmptyBoard size

  for j in [0...size]
    for i in [0...size]
      empty[j][i] = board[j][i]

  return empty

getTileNumbers = (nTiles) ->
  [0...nTiles]

isEmpty = (board, [i, j]) ->
  !board[j][i]?

hasEmpty = (board) ->
  size = getBoardSize board
  for i in [0...size]
    for j in [0...size]
      if isEmpty board, [j, i]
        return true
  return false

hasTiles = (board) ->
  size = getBoardSize board
  for i in [0...size]
    for j in [0...size]
      if not isEmpty board, [j, i]
        return true
  return false

getRandomEmptyLocation = (board) ->
  size = getBoardSize board

  if not hasEmpty board
    return

  for i in [0...size]
    for j in [0...size]

      if isEmpty(board, [i, j]) and Math.random() < (1.0 / size)
        return [i, j]

  # try again
  return getRandomEmptyLocation board

addInitialTiles = (board, nTiles) ->
  board = cloneBoard(board)
  size = getBoardSize board

  for k in getTileNumbers(nTiles)
    if hasEmpty board
      [i, j] = getRandomEmptyLocation board
      board[j][i] = k

  return board

randInt = (min, max) ->
  return Math.floor(Math.random() * (max - min)) + min

chooseRandomly = (choices) ->
  index = randInt 0, choices.length
  return choices[index]

getNeighbours = (board, [i, j]) ->
  neighbours = []
  size = getBoardSize board

  if j - 1 >= 0
    neighbours.push board[j-1][i]

  if j + 1 < size
    neighbours.push board[j+1][i]

  if i - 1 >= 0
    neighbours.push board[j][i-1]

  if i + 1 < size
    neighbours.push board[j][i+1]

  return _.unique neighbours

addRemainingTiles = (board, nTiles) ->
  board = cloneBoard board

  while hasEmpty board
    [i, j] = getRandomEmptyLocation board
    board[j][i] = chooseRandomly getNeighbours board, [i, j]

  return board

fillBoard = (board, nTiles) ->
  board = cloneBoard(board)
  return addRemainingTiles addInitialTiles(board, nTiles), nTiles

boardToString = (board) ->
  size = getBoardSize board
  s = ''

  for j in [0...size]
    s += "#{j}: "
    for i in [0...size]
      if isEmpty board, [i, j]
        s += '. '
      else
        s += board[j][i] + ' '

    s += '\n'

  return s

getOnly = (board, tile) ->
  board = cloneBoard board
  size = getBoardSize board

  for j in [0...size]
    for i in [0...size]
      if board[j][i] isnt tile
        board[j][i] = null

  return board

boardToTiles = (board, nTiles) ->
  tiles = []

  for tile in getTileNumbers nTiles
    tiles.push getOnly board, tile

  return tiles

leftIsEmpty = (board) ->
  size = getBoardSize board
  for j in [0...size]
    if not isEmpty board, [0, j]
      return false

  return true

topIsEmpty = (board) ->
  size = getBoardSize board
  for i in [0...size]
    if not isEmpty board, [i, 0]
      return false

  return true

shiftUp = (board) ->
  size = getBoardSize board
  newBoard = cloneBoard board

  for j in [1...size]
    for i in [0...size]
      newBoard[j - 1][i] = board[j][i]

  for i in [0...size]
    newBoard[size - 1][i] = null

  return newBoard

shiftLeft = (board) ->
  size = getBoardSize board
  newBoard = cloneBoard board

  for j in [0...size]
    for i in [1...size]
      newBoard[j][i - 1] = board[j][i]

  for j in [0...size]
    newBoard[j][size - 1] = null

  return newBoard

trimBoard = (board) ->
  board = cloneBoard board

  if hasTiles board
    while leftIsEmpty board
      board = shiftLeft board

  if hasTiles board
    while topIsEmpty board
      board = shiftUp board

  return board

trimTiles = (tiles) ->
  tiles.map trimBoard

sameBoard = (a, b) ->
  size = getBoardSize a
  bsize = getBoardSize b

  if size isnt bsize
    return false

  aHasTiles = hasTiles(a)
  bHasTiles = hasTiles(b)

  if aHasTiles isnt bHasTiles
    return false

  if !aHasTiles and !bHasTiles
    return true

  for j in [0...size]
    for i in [0...size]
      if a[j][i] isnt b[j][i]
        return false

  return true

tilesMatch = (as, bs) ->
  if as.length isnt bs.length
    return false

  for a in as
    found = _.find bs, (b) -> sameBoard a, b
    if !found
      return false

  return true

tiledBy = (board, tiles, nTiles) ->
  createdTiles = boardToTiles(board, nTiles).map(trimBoard)

  return tilesMatch createdTiles, tiles

getTiles = (board, nTiles) ->
  return boardToTiles(board, nTiles).map(trimBoard)

runTest = (getTiledBoard) ->
  size = 4
  nTiles = 4
  board = fillBoard(getEmptyBoard(size), nTiles)
  tiles = getTiles(board, nTiles)

  console.log 'Tiles:\n'
  console.log getTiles(board, nTiles).map(boardToString).join('\n')

  console.log 'Original tiling:\n'
  console.log boardToString board

  tiledBoard = getTiledBoard getEmptyBoard(size), tiles

  console.log 'Your tiling:\n'
  console.log boardToString tiledBoard

  if tiledBy tiledBoard, tiles, nTiles
    console.log 'Your solution worked!'
  else
    console.log 'Your solution is not correct!'

getTiledBoard = (emptyBoard, tiles) ->
  # --------- Your code goes in here -----------
  return emptyBoard
  # --------- Your code ends here --------------

main = ->
  runTest getTiledBoard

main()
