//
//  MiniMax.swift
//  TTT-MiniMax
//
//  Created by Cyril Garcia on 12/14/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

final class GameMiniMax: Game {

    public func aiMove() {
        var bestScore = -1
        var bestMove = 0
        
        for i in 0..<boardState.count {
            
            if boardState[i] == 0 {
                
                boardState[i] = ai
                let score = miniMax(boardState, 0, false)
                boardState[i] = 0
                
                if score > bestScore {
                    bestScore = score
                    bestMove = i
                }
            }
        }
        
        boardState[bestMove] = ai
        delegate?.play(at: bestMove, player: ai)
        guard let gameState = checkGameState() else { return }
        delegate?.gameState(gameState)
        
    }
    
    private func miniMax(_ board: [Int], _ depth: Int, _ isMaximizing: Bool) -> Int {
        
        if let results = checkGameState()?.rawValue {
            return results
        }
                
        if isMaximizing {
            var bestScore = -2
            
            for i in 0..<boardState.count {
                if boardState[i] == 0 {
                    boardState[i] = ai
                    let score = miniMax(boardState, depth + 1, false)
                    boardState[i] = 0
                    bestScore = max(score, bestScore)
                }
            }
            return bestScore

        } else {
            var bestScore = 2
            
            for i in 0..<boardState.count {
                if boardState[i] == 0 {
                    boardState[i] = human
                    let score = miniMax(boardState, depth + 1, true)
                    boardState[i] = 0
                    bestScore = min(score, bestScore)
                }
            }
            return bestScore
        }

    }
    
    
}
