//
//  GameViewModel.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 13/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI



final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int) {
        // human move processing
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .human, boardIndex: position)
        isGameboardDisabled = true
        
        if checkWinCondition(for: .human, in: moves) {
            print("Human Win")
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            print("Draw")
            alertItem = AlertContext.draw
            return
        }
        
        
        // computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in

            let computerPosition = determinateComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                print("Computer Win")
                alertItem = AlertContext.computerwin
                return
            }

            if self.checkForDraw(in: moves) {
                print("Draw")
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    
    func isSquareOccupied(in move: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determinateComputerMovePosition(in moves: [Move?]) -> Int {
        // if AI can win, then Win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap { $0 }.filter {$0.player == .computer}
        let computesPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computesPositions)
            
            if winPositions.count == 1 {
                let isAvaliable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaliable { return winPositions.first! }
            }
        }
        
        
        // IF Ai can't win, then block
        let humanMoves = moves.compactMap { $0 }.filter {$0.player == .human}
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvaliable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaliable { return winPositions.first! }
            }
        }
        
        // if AI can/t block, then take middle squaređ
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        // if AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter {$0.player == player}
        let playerPosition = Set(playerMoves.map { $0.boardIndex })
        print(playerPosition)
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) {
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        alertItem = nil
        moves = Array(repeating: nil, count: 9)
        isGameboardDisabled = false
    }
    
}
