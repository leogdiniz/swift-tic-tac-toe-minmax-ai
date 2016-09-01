//
//  Board.swift
//  TicTacToe
//
//  Created by Leonardo Guimarães Diniz on 8/31/16.
//  Copyright © 2016 Leogdiniz. All rights reserved.
//

import Foundation

class Board:NSObject{
    
    var boardState: [Int]
    var winningStates = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    init(boardState: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]){
        self.boardState = boardState;
    }
    
}

//MaxMin algorithm
extension Board{
    func resetBoardState() {
        self.boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    
    func getBoardState() -> [Int] {
        return self.boardState
    }
    
    func addMove(player: Int!, atPosition:Int!) {
        self.boardState[atPosition] = player
    }
    
    func getMove(atPosition:Int!) -> Int {
        return self.boardState[atPosition]
    }
    
    //Check if there is a winner comparing the board state with all the possible winning states
    func checkGameStatus() -> TicTacToeAI.gameStatus{
        for winnerState in winningStates{
            if boardState[winnerState[0]] != 0 && boardState[winnerState[0]] == boardState[winnerState[1]] && boardState[winnerState[1]] == boardState[winnerState[2]] {
                if boardState[winnerState[0]] == 1{
                    return TicTacToeAI.gameStatus.HUMAN_WIN
                }else{
                    return TicTacToeAI.gameStatus.COMPUTER_WIN
                }
            }
            
        }
        if !boardState.contains(0) {
            return TicTacToeAI.gameStatus.DRAW
        }
        
        return TicTacToeAI.gameStatus.IN_PROGRESS
    }
    
    func getAvailableMoves() -> [Int]{
        var stateCopy = self.boardState;
        var availableMoves:[Int] = []
        var index = stateCopy.indexOf(0)
        while index  != nil {
            availableMoves.append(index!)
            stateCopy[index!] = -1
            index = stateCopy.indexOf(0)
        }
        return availableMoves
    }
    
}
