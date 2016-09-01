//
//  ViewController.swift
//  TicTacToe
//
//  Created by Leonardo Guimarães Diniz on 8/31/16.
//  Copyright © 2016 Leogdiniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gameOverLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    var gameActive = true
    var board:Board = Board()
    var AI:TicTacToeAI = TicTacToeAI()

	//Executed everyt time the player makes a move
    @IBAction func buttonPressed(sender: UIButton) {
        if board.getMove(sender.tag - 1) == 0 && gameActive{
            sender.setTitle("0", forState: .Normal)
            sender.setTitleColor(.blackColor(), forState: .Normal)
            self.board.addMove(Player.HUMAN, atPosition: sender.tag - 1)
			//Stop the game until the computer makes it's move
			gameActive = false;
			//Executes computer's move after 0.3 seconds just to give an impression it's thinking
			dispatch_after(
				dispatch_time(
					DISPATCH_TIME_NOW,
					Int64(0.3 * Double(NSEC_PER_SEC))
				),
				dispatch_get_main_queue(),
				{self.playComputerMove()}
			)
        }
    }

	//Restarts the game
    @IBAction func restartGame(sender: AnyObject) {
        gameActive = true
        board.resetBoardState()
        hideButtons()
        hideWinningMessage()
        
    }
	
	//Makes AI's move
    private func playComputerMove(){
        let nextMove = self.AI.nextMove(self.board, player: Player.COMPUTER)
        if(nextMove >= 0){
            let button: UIButton = self.view.viewWithTag(nextMove + 1) as! UIButton
            button.setTitle("X", forState: .Normal)
            button.setTitleColor(.blackColor(), forState: .Normal)
            self.board.addMove(Player.COMPUTER, atPosition: nextMove)
        }
        let status: TicTacToeAI.gameStatus = self.board.checkGameStatus();
        if(status != TicTacToeAI.gameStatus.IN_PROGRESS){
            switch status {
            case TicTacToeAI.gameStatus.COMPUTER_WIN:
                self.displayEndGameMessage("Computer win!")
            case TicTacToeAI.gameStatus.HUMAN_WIN:
                self.displayEndGameMessage("You win!")
            case TicTacToeAI.gameStatus.DRAW:
                self.displayEndGameMessage("Draw!")
            default:
                break
            }
            
            gameActive = false;
		}else{
			gameActive = true;
		}
    }
	
	//Clean the board
    private func hideButtons() {
        for i in 1...9 {
            let button: UIButton = view.viewWithTag(i) as! UIButton
            button.setTitleColor(.whiteColor(), forState: .Normal)
        }
    }
    
    private func displayEndGameMessage(message:String){
        gameOverLabel.text = message
        gameOverLabel.hidden = false
        playAgainButton.hidden = false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
        })
    }
    
    private func hideWinningMessage(){
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideWinningMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

