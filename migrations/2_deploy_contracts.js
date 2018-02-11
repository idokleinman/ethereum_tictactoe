var TicTacToeContract = artifacts.require("./tictactoe.sol");

module.exports = function(deployer) {
  deployer.deploy(TicTacToeContract);
};
