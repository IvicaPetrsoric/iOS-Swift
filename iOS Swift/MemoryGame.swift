//
//  MemoryGame.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 16/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation


struct MemoryGame<CardContent> {
    
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("Card choosen \(card)")
        
        if let choosenIndex: Int = self.index(of: card) {
            self.cards[choosenIndex].isFaceUp = !self.cards[choosenIndex].isFaceUp
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        
        return nil
    }
    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}


