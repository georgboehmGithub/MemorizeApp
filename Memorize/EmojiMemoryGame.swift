//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//  Created by Georg Boehm on 11.12.22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // TODO: Move to Theme model
    static let themes: Array<Theme> = [Theme(color: "orange", name: "sport", numberOfCards: 4),
                                       Theme(color: "red", name: "food", numberOfCards: 6),
                                       Theme(color: "blue", name: "flags", numberOfCards: 8)]
    
    static func createMemoryGame() -> MemoryGame<String> {
        if let randomTheme = themes.randomElement() {
            return MemoryGame<String>(numberOfPairsOfCards: randomTheme.numberOfCards) {pairIndex in randomTheme.pickedEmojis[pairIndex]}
        } else {
            let firstTheme = themes[0]
            return MemoryGame<String>(numberOfPairsOfCards: firstTheme.numberOfCards) {pairIndex in firstTheme.pickedEmojis[pairIndex]}
        }
    }
    
//    static func pickTheme() -> Theme {
//        if let chosenTheme = themes.randomElement() { // returns Optional
//            return chosenTheme
//        } else {
//            return themes[0]
//        }
//    }
    
    // TODO: Hints 13 and 14 in assignment
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func rollTheme() {
        model = EmojiMemoryGame.createMemoryGame()
        print(model)
    }
}
