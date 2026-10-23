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
    
    @State var game = CodeBreaker()
        
    var body: some View {
        VStack {
            view(for: game.masterCode)
            view(for: game.guess)
//            pegs(colors: game.attempts[0].pegs)
        }
        .padding()
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }
            
            MatchMarkers(match: [.exact, .inexact, .nomatch, .exact])
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
