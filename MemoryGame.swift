//
//  MemoryGame.swift
//  Memorize
//  Model
//  Created by Georg Boehm on 11.12.22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{ // behaves like an Equatable
    private(set) var cards: Array<Card>
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter( {cards[$0].isFaceUp}).oneAndOnly}
        set { cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { // True if Optional is not nil
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Cards match -> Score + 2
                    self.score += 2
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                } else {
                    // Mismatch -> If cards have previously been seen, deduct one point for each seen card
                    self.score -= (cards[chosenIndex].seen ? 1 : 0) + (cards[potentialMatchIndex].seen ? 1 : 0)
                    self.cards[chosenIndex].seen = true // set again redundantly but w/e
                    self.cards[potentialMatchIndex].seen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else { // Optional is nil
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var seen = false
        let content: CardContent
        let id: Int
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        self.score = 0
        cards = []
        // Add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
        }
        self.cards = cards.shuffled()
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
