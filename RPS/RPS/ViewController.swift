//
//  ViewController.swift
//  RPS
//
//  Created by wickedRun on 2021/06/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appSign: UILabel!
    @IBOutlet weak var gameState: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    var state: GameState = .start
    var mySign: Sign?
    var anotherSign: Sign?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewForState()
        // Do any additional setup after loading the view.
    }

    @IBAction func signTapped(_ sender: UIButton) {
        switch sender {
        case rockButton:
            mySign = Sign.rock
            anotherSign = mySign!.randomSign()
            paperButton.isHidden = true
            scissorButton.isHidden = true
            state = mySign!.comparison(anotherSign: anotherSign!)
            updateViewForState()
        case paperButton:
            mySign = Sign.paper
            anotherSign = mySign!.randomSign()
            rockButton.isHidden = true
            scissorButton.isHidden = true
            state = mySign!.comparison(anotherSign: anotherSign!)
            updateViewForState()
        case scissorButton:
            mySign = Sign.scissor
            anotherSign = mySign!.randomSign()
            state = mySign!.comparison(anotherSign: anotherSign!)
            rockButton.isHidden = true
            paperButton.isHidden = true
            updateViewForState()
        default:
            mySign = nil
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        state = .start
        updateViewForState()
    }
    
    func updateViewForState() {
        switch state {
        case .start:
            appSign.text = "🤖"
            gameState.text = "Rock, Paper, Scissors?"
            view.backgroundColor = .darkGray
            playAgainButton.isHidden = true
            rockButton.isEnabled = true
            paperButton.isEnabled = true
            scissorButton.isEnabled = true
            rockButton.isHidden = false
            paperButton.isHidden = false
            scissorButton.isHidden = false
        case .win:
            gameState.text = "You Won!"
            appSign.text = anotherSign?.rawValue
            view.backgroundColor = .green
            playAgainButton.isHidden = false
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorButton.isEnabled = false
            
        case .lose:
            gameState.text = "You Lose.."
            appSign.text = anotherSign?.rawValue
            view.backgroundColor = .red
            playAgainButton.isHidden = false
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorButton.isEnabled = false
        case .draw:
            gameState.text = "Draw"
            appSign.text = anotherSign?.rawValue
            view.backgroundColor = .lightGray
            playAgainButton.isHidden = false
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorButton.isEnabled = false
        }
    }
}

