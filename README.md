# ethereum_tictactoe
Ethererum smart contract for multiple TicTacToe 2 player games

See `./contracts/tictactoe.sol` for Solidity contract code

This is run in a Truffle box on a JS VM machine or on Remix for direct interaction via https://remix.ethereum.org/

**Functions**

_makeGame_ - create a new game, receives *player1_address*, *player2_address*, returns *gameid*
_makeTurn_ - make a turn in the game, receives *gameid*, *square_x*, *square_y*, returns KEEP_PLAYING, WIN, LOSE, DRAW
