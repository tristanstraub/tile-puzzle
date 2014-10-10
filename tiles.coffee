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

main = ->
  size = 4
  nTiles = 4
  board = fillBoard(getEmptyBoard(size), nTiles)
  console.log boardToTiles(board, nTiles).map(boardToString).join('\n')

main()
