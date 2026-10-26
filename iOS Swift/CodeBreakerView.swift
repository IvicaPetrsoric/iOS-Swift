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
    
    // MARK: DAta Owned by me
    @State private var game = CodeBreaker(pegChoices: [.red, .green, .blue, .yellow])
    @State private var selection: Int = 0
        
    // MARK: - Body
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            
            ScrollView {
                view(for: game.guess)
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            pegChooser
        }
        .padding()
    }
    
    var pegChooser: some View {
        HStack {
            ForEach(game.pegChoices, id: \.self) { peg in
                Button{
                    game.setGuessPeg(peg, at: selection)
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                    PegView(peg: code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
//                            game.changeGuessPeg(at: index)
                        }
                    }
            }
            
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(match: matches)
                    } else {
                        if code.kind == .guess {
                            guessButton
                        }
                    }
                }
            }
    }
    

}


#Preview {
    CodeBreakerView()
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CodeBreakerView()
        }
    }
}
