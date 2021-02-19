//
//  MemoryGame.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 16/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var indeOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardsIndices = cards.indices.filter { cards[$0].isFaceUp }.only
            return faceUpCardsIndices
            
            //            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardsIndices.append(index)
//                }
//            }
            
//            if faceUpCardsIndices.count == 1 {
//                return faceUpCardsIndices.first
//            } else {
//                return nil
//            }
        } set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("Card choosen \(card)")
        
//        if let choosenIndex: Int = self.index(of: card),
        if let choosenIndex: Int = cards.firstIndex(matching: card),
           !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched  {
            
            if let potentionalMatchIndex = indeOfTheOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentionalMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentionalMatchIndex].isMatched = true
                }
                
                self.cards[choosenIndex].isFaceUp = true
            } else {
                indeOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
        }
    }
    
//    func index(of card: Card) -> Int? {
//        for index in 0..<self.cards.count {
//            if self.cards[index].id == card.id {
//                return index
//            }
//        }
//
//        return nil
//    }
    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id: Int
        
        // MARK:- Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    
    

    
    
}


// ARRAY + ONLY
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
