//
//  TicTacToe.swift
//  TTT-MiniMax
//
//  Created by Cyril Garcia on 12/14/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import Foundation

protocol GameDelegate {
    func gameState(_ state: GameState)
    func play(at i: Int, player: Int)
}

enum GameState: Int {
    case tie = 0
    case x_win = 1
    case o_win = -1
}

class Game {
    
    private let winningCombo = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var boardState = [0,0,0,0,0,0,0,0,0]
    let ai = 1
    let human = -1
    
    var delegate: GameDelegate?
    
    public func play(_ i: Int) {
        if boardState[i] != 0 {
            return
        }
        
        boardState[i] = human
        delegate?.play(at: i, player: human)
        
        guard let state = checkGameState() else { return }
        delegate?.gameState(state)
    }
    
    public func checkGameState() -> GameState? {
        
        for combo in winningCombo {
            let x = combo[0]
            let y = combo[1]
            let z = combo[2]
            
            if equals(boardState[x], boardState[y], boardState[z]) {
                if boardState[x] == ai {
                    return .x_win
                } else {
                    return .o_win
                }
            }
        }
        
        var spaces = 0
        
        for board in boardState {
            if board == 0 {
                spaces += 1
            }
        }
        
        if spaces == 0 {
            return .tie
        } else {
            return nil
        }
    }
    
    public func restart() {
        boardState = [0,0,0,0,0,0,0,0,0]
    }

    private func equals(_ a: Int,_ b: Int,_ c: Int) -> Bool {
        return a == b && b == c && a != 0
    }

}
