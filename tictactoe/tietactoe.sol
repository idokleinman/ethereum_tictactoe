pragma solidity ^0.4.18;

contract TicTacToe {
    struct Game {
        address[] board;
        address x;
        address o;
        address currentPlayer;
        uint totalTurns;
        bool isComplete;
    }

    Game[] games;

    function TicTacToe() public payable {
    }

    function makeGame(address p1, address p2) public payable returns (uint) {
        require((p1 != 0) && (p2 != 0));
        games.push(Game(new address[](9), p1, p2, p1, 0, false));
        return (uint)(games.length - 1);
    }

    function getBoard(uint index) public view returns (address[]) {
        require(games.length >= index);
        return games[index].board;
    }

    // gameId, player
    event GameComplete(uint, address);

    // gameId, nextPlayer
    event NextTurn(uint, address);

    function makeTurn(uint gameId, uint x, uint y) public payable returns (string) {
        Game storage game = games[gameId];
        require(game.currentPlayer == msg.sender);
        require(game.board[x + 3*y] == 0); // No Move Yet
        require(game.isComplete == false);

        address otherPlayer = msg.sender == game.x ? game.o : game.x;

        game.board[x + 3*y] = msg.sender;
        game.currentPlayer = otherPlayer;

        if (isWin(game.board, msg.sender)) {
            GameComplete(gameId, msg.sender);
            game.isComplete = true;
            return 'WIN';
        } else if (isWin(game.board, otherPlayer)) {
            GameComplete(gameId, otherPlayer);
            game.isComplete = true;
            return 'LOSE';
        } else if (game.totalTurns >= 9) {
            GameComplete(gameId, 0x0);
            game.isComplete = true;
            return 'DRAW';
        } else {
            NextTurn(gameId, otherPlayer);
            return 'KEEP_PLAYING';
        }
    }

    function isWin(address[] b, address p) public pure returns (bool) {
        return (
        b[0] == p && b[1] == p && b[2] == p ||
        b[3] == p && b[4] == p && b[5] == p ||
        b[6] == p && b[7] == p && b[8] == p ||

        b[0] == p && b[3] == p && b[6] == p ||
        b[1] == p && b[4] == p && b[7] == p ||
        b[2] == p && b[5] == p && b[8] == p ||

        b[0] == p && b[4] == p && b[8] == p ||
        b[6] == p && b[4] == p && b[2] == p);
    }
}
