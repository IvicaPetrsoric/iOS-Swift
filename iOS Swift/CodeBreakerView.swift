//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI


enum Match {
    case nomatch
    case exact
    case inexact
}

struct CodeBreakerView: View {
    
    // MARK: Data in
    @Environment(\.words) private var words
    
    let game: CodeBreaker
    
    // MARK: DAta Owned by me
//    @State private var game = CodeBreaker(pegChoices: [.red, .green, .blue, .yellow])

    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRecentMarkers = false
        
    // MARK: - Body
    
    var body: some View {
        VStack {            
            CodeView(code: game.masterCode) {

            }

            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
                        guessButton
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)
                }
                
                ForEach(game.attempts, id: \.pegs) { attempt in
                    CodeView(code: attempt) {
                        let showmarkers = !hideMostRecentMarkers || attempt.pegs != game.attempts.first?.pegs
                        if showmarkers, let matches = attempt.matches {
                            MatchMarkers(match:  matches)
                        }
                    }
                    .transition(.attempt(game.isOver))
                }
            }
            
            if !game.isOver {
                PegChooser(choices: game.pegChoices, onChoose: changePegAtSelection)
                    .transition(.pegChooser)
                    .frame(maxHeight: 90)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Restart", systemImage: "arrow.circlepath" ,action: restart)

            }
            
            ToolbarItem {
                ElapsedTime(startTime: game.startTime, endTime: game.endTime)
    //                .flexibleSystemFont()
                    .monospaced()
                    .lineLimit(1)
            }

        }
        .padding()
    }
    
    private func restart() {
        withAnimation(.restart) {
            restarting = game.isOver
            game.restart()
            selection = 0
        } completion: {
            withAnimation(.restart) {

                restarting = false
            }
        }
    }
    
    func changePegAtSelection(to peg: Peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
    }
        
    var guessButton: some View {
        Button("Guess", action: guess)
            .flexibleSystemFont()
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximusFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximusFontSize
    }
    
    private func guess() {
        withAnimation(.guess) {
            game.attemptGuess()
            selection = 0
            hideMostRecentMarkers = true
        } completion: {
            withAnimation(.guess) {
                hideMostRecentMarkers = false
            }
        }
        
//            print("random word = \(words.random(length: 5) ?? "None")")
    }

}


#Preview {
    @Previewable @State var game = CodeBreaker(name: "Mastermind", pegChoices: [.red, .blue, .green, .yellow])
    CodeBreakerView(game: game)
}


struct StartView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            @State var game = CodeBreaker(name: "Mastermind", pegChoices: [.red, .blue, .green, .yellow])
            CodeBreakerView(game: game)
        }
    }
}
