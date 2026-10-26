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
                if !game.isOver {
                    view(for: game.guess)
                }
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            PegChooser(choices: game.pegChoices, onChoose: { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.masterCode.pegs.count
            })
        }
        .padding()
    }
        
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximusFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            CodeView(code: code, selection: $selection)
            
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
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximusFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximusFontSize
    }
    

}


#Preview {
    CodeBreakerView()
}

extension Color {
    
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CodeBreakerView()
        }
    }
}
