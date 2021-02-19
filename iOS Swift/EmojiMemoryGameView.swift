//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.3)) {
                        viewModel.chooseCard(card: card)
                    }
                }.padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            .font(.largeTitle)
            
            Button {
                withAnimation(.easeOut) {
                    viewModel.resetGame()
                }
            } label: {
                Text("Reset Game")
            }

        }
        

    }
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animateBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animateBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animateBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animateBonusRemaining * 360 - 90), clockwise: true)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)



                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
    //        .modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }

    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
            let game = EmojiMemoryGame()
            game.chooseCard(card: game.cards[0])
            return EmojiMemoryGameView(viewModel: game)
//        }
    }
}



// CARDIFY
struct Cardify: AnimatableModifier {
    
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)

            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)

        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
}
