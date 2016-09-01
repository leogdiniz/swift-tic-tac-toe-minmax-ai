//
//  AI.swift
//  TicTacToe
//
//  Created by Leonardo Guimarães Diniz on 8/31/16.
//  Copyright © 2016 Leogdiniz. All rights reserved.
//

import Foundation

class Player {
    static let HUMAN = 1
    static let COMPUTER = 2
}

class TicTacToeAI: NSObject {
    enum gameStatus {case HUMAN_WIN
                     case COMPUTER_WIN
                     case DRAW
                     case IN_PROGRESS
                    }
    
}

extension TicTacToeAI {
    
    private func minMax(game:Board, player: Int, depth: Int) -> [Int]{
		//In case the center of the board has not been taken yet, take it first
        if game.boardState[4] == 0{
            return [0, 4]
        }
		let availableMoves: [Int] = game.getAvailableMoves()
		let status: TicTacToeAI.gameStatus = game.checkGameStatus()
        var bestMove = -1
		var bestScore: Int = player == Player.COMPUTER ? Int.min : Int.max
		var score: Int
		//If game is over, evalute the situation
		if(status != gameStatus.IN_PROGRESS || availableMoves.count == 0){
			return evaluateScore(status, depth: depth, bestMove: bestMove)
		}
		//Check the outcome of all available moves
		for move in availableMoves{
			let nextGameState: Board = Board(boardState: game.getBoardState())
			nextGameState.addMove(player, atPosition: move)
			
			if(player == Player.COMPUTER){
				score = minMax(nextGameState, player: Player.HUMAN, depth: depth + 1)[0]
				//Maxmizes for the computer
				if score > bestScore {
					bestScore = score
					bestMove = move
				}
			}else{
				score = minMax(nextGameState, player: Player.COMPUTER, depth: depth + 1)[0]
				//Minimizes for the player
				if score < bestScore {
					bestScore = score
					bestMove = move
				}
			}
		}
        
        return [bestScore, bestMove]
    }
	
	private func evaluateScore(status: TicTacToeAI.gameStatus, depth: Int, bestMove: Int) -> [Int]{
		if status == gameStatus.HUMAN_WIN {
			return [depth - 10, bestMove]
		} else {
			if status == gameStatus.COMPUTER_WIN {
				return [10 - depth, bestMove]
			} else {
				return [0, bestMove]
			}
		}
	}
	
    func nextMove(board: Board, player: Int) -> Int{
        return minMax(board, player: player, depth: 0)[1]
    }
}