//
//  ViewController.swift
//  TTT-MiniMax
//
//  Created by Cyril Garcia on 12/14/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameDelegate {
    
    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    
    private var buttons = [UIButton]()

    private var game = GameMiniMax()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupButton()
        game.delegate = self
        game.aiMove()
    }
    
    func setupButton() {
        buttons = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        for i in 0..<buttons.count {
            buttons[i].tag = i
            buttons[i].setTitle("-", for: .normal)
            buttons[i].addTarget(self, action: #selector(didPress(_:)), for: .touchUpInside)
        }
    }
    
    @objc
    func didPress(_ sender: UIButton) {
        game.play(sender.tag)
        game.aiMove()
        
    }
    
    func play(at i: Int, player: Int) {
        
        if player == 1 {
            buttons[i].setTitle("X", for: .normal)
        } else {
            buttons[i].setTitle("O", for: .normal)
        }
    }

    func gameState(_ state: GameState) {
        
        switch state {
        case .x_win:
            alert(message: "X Wins")
        case .o_win:
            alert(message: "O Wins")
        case .tie:
            alert(title: "Tie!")
        }
        
    }
    
    private func alert(title: String = "Game Over", message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func restart() {
        setupButton()
        game.restart()
        game.aiMove()
    }
}

