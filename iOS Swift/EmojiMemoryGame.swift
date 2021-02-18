//
//  EmojiMemoryGame.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 16/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI

//func createCardContent(pairIndex: Int) -> String {
//    return "👻"
//}

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🎃", "👻", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    
    // MARK: - Acces to the model
    
    var cards: Array<MemoryGame<String>.Card> {
//        return model.cards
        model.cards
    }
    
    // MARK: - Intents
        
    // intents
    func chooseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}


