//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//  Created by Georg Boehm on 11.12.22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var theme: Theme
    @Published private var model: MemoryGame<String>
    private let memoryGameData: memoryGameData
    
    static func createMemoryGame(withTheme usedTheme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: usedTheme.numberOfCards) {pairIndex in usedTheme.pickedEmojis[pairIndex]}
    }
    
    func getThemeColor() -> Color {
        let themeColor: String = theme.color
        
        switch themeColor {
        case "blue":
            return Color(.blue)
        case "red":
            return Color(.red)
        case "yellow":
            return Color(.yellow)
        case "green":
            return Color(.green)
        case "purple":
            return Color(.purple)
        case "orange":
            return Color(.orange)
        default:
            return Color(.red)
        }
    }
    
    init() {
        self.memoryGameData = Memorize.memoryGameData()
        let newTheme: Theme = self.memoryGameData.selectRandomTheme()
        self.theme = newTheme
        self.model = EmojiMemoryGame.createMemoryGame(withTheme: newTheme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = memoryGameData.selectRandomTheme()
        model = EmojiMemoryGame.createMemoryGame(withTheme: theme)
    }
}
