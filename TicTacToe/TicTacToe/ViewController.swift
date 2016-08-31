//
//  ViewController.swift
//  TicTacToe
//
//  Created by Leonardo Guimarães Diniz on 8/31/16.
//  Copyright © 2016 Motoboy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gameOverLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    var gameActive = true
    var activePlayer = 1;//1 = O, 2 = X
    var boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningStates = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    @IBAction func buttonPressed(sender: UIButton) {
        if boardState[sender.tag - 1] == 0 && gameActive{
            sender.setTitle(activePlayer == 1 ? "O" : "X", forState: .Normal)
            sender.setTitleColor(.blackColor(), forState: .Normal)
            boardState[sender.tag - 1] = activePlayer;
            activePlayer = activePlayer == 1 ? 2 : 1
            
            checkWinner()
        }
    }
    
    //Check if there is a winner comparing the board state with all the possible winning states
    private func checkWinner(){
        for winnerState in winningStates{
            if boardState[winnerState[0]] != 0 && boardState[winnerState[0]] == boardState[winnerState[1]] && boardState[winnerState[1]] == boardState[winnerState[2]]{
                print("We have a winner")
                if boardState[winnerState[0]] == 1{
                    gameOverLabel.text = "Noughts has won";
                }else{
                    gameOverLabel.text = "Crosses has won";
                }
                displayWinningMessage()
                gameActive = false;
            }
        }
    }
    
    @IBAction func restartGame(sender: AnyObject) {
        gameActive = true
        activePlayer = 1;//1 = O, 2 = X
        boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        hideButtons()
        hideWinningMessage()
        
    }
    
    private func hideButtons() {
        for i in 1...9 {
            let button: UIButton = view.viewWithTag(i) as! UIButton
            button.setTitleColor(.whiteColor(), forState: .Normal)
        }
    }
    
    private func displayWinningMessage(){
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
        // Dispose of any resources that can be recreated.
    }


}

