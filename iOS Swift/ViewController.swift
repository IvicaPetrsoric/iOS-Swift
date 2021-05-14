//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

// model
struct Game {
    enum Move: String, CaseIterable {
        case rock = "✊"
        case scissors = "✌️"
        case papers = "👋"
        
        static var winingMoves: [Move: Move] {
            [
                .rock : .scissors,
                .papers : .rock,
                .scissors : .papers,
            ]
        }
    }
    
    enum Player {
        case one, two
    }
    
    enum Result {
        case win, draw, loss
    }
    
    let allMoves = Move.allCases
    
    var activePlayer = Player.one
    var moves: (first: Move?, second: Move?) = (nil , nil) {
        didSet {
            activePlayer = (moves.first != nil && activePlayer == .one) ? .two : .one
        }
    }
    var isGameOver: Bool {
        return moves.first != nil && moves.second != nil
    }
    
    var winner: Player? = nil
    
    func evaluateResults() -> Result? {
        guard let firstMove = moves.first, let secondMove = moves.second else { return nil }
        
        if firstMove == secondMove {
            return .draw
        }
        
        if let neededMoveToWin = Move.winingMoves[firstMove], secondMove == neededMoveToWin {
            return .win
        }
        
        return .loss
    }
    
}

//ViewModel
final class GameViewModel: ObservableObject {
    @Published private var model = Game()
    
    func getAllowedMoves(forPlayer player: Game.Player) -> [Game.Move] {
        if model.activePlayer == player && !model.isGameOver {
            return model.allMoves
        }
        
        return []
    }
    
    func getStatusText(forPlayer player: Game.Player) -> String {
        if !model.isGameOver {
            return model.activePlayer == player ? "" : "..."
        }
        
        if let result = model.evaluateResults() {
            switch result {
            case .win:
                return player == .one ? "You Win!" : "You Lost!"
            case .loss:
                return player != .one ? "You Win!" : "You Lost!"
            case .draw:
                return "DRAW"
            }
        }
        
        return "Undefined state"
    }
    
    func getFinalMove(forPlayer player: Game.Player) -> String {
        if model.isGameOver {
            switch player {
            case .one:
                return model.moves.first?.rawValue ?? ""
            case .two:
                return model.moves.second?.rawValue ?? ""
            }
        }
        
        return ""
    }
    
    func isGameOver() -> Bool {
        return model.isGameOver
    }
    
    func choose(_ move: Game.Move, forPlayer player: Game.Player) {
        print("Player \(player) choose \(move.rawValue)")
        
        if player == .one {
            model.moves.first = move
        } else {
            model.moves.second = move
        }
    }
    
    func resetGame() {
        model.activePlayer = .one
        model.moves = (nil, nil)
        model.winner = nil
    }
    
}


// View
struct StartView: View {
    
    @ObservedObject var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.purple
                Text("Player 2")
                
                VStack {
                    Spacer()
                    Text(viewModel.getFinalMove(forPlayer: .two))
                    Spacer()
                    Text(viewModel.getStatusText(forPlayer: .two))

                    HStack {
                        ForEach(viewModel.getAllowedMoves(forPlayer: .two), id: \.self) { move in
                            Button(move.rawValue) {
                                self.viewModel.choose(move, forPlayer: .two)
                            }
                        }
                    }
                    Spacer()
                }.padding(.bottom, 40)

            }.rotationEffect(.degrees(180))
            
            if viewModel.isGameOver() {
                Button("Reset") {
                    self.viewModel.resetGame()
                }
                .foregroundColor(.blue)
            }
            
            ZStack {
                Color.blue
                VStack {
                    Text("Player 1")
                    Spacer()
                    Text(viewModel.getFinalMove(forPlayer: .one))
                    Spacer()
                    Text(viewModel.getStatusText(forPlayer: .one))

                    HStack {
                        ForEach(viewModel.getAllowedMoves(forPlayer: .one), id: \.self) { move in
                            Button(move.rawValue) {
                                self.viewModel.choose(move, forPlayer: .one)
                            }
                        }
                    }
                    Spacer()
                }.padding(.bottom, 40)
                
            }
        }.foregroundColor(.white)
        .font(.title)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
