//
//  Theme.swift
//  Memorize
//
//  Created by Georg Boehm on 12.12.22.
//

import Foundation

enum chosenTheme: String{
    case food = "food"
    case sport = "sport"
    case flags = "flags"
}

struct Theme {
    private (set) var numberOfCards: Int
    private (set) var color, name: String
    private (set) var allEmojis = ["🌯", "🍫", "🍭", "🍞", "🥨", "🍙", "🥕", "🧀", "🍔","🍖", "🥚", "🥩", "🥗", "🥠", "🍩", "🍡", "🍣", "🌭", "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏒", "🪃", "🥊", "🤿", "🥌", "🎣", "⛷", "🏳️", "🏴‍☠️", "🏳️‍🌈", "🚩", "🇦🇹", "🇨🇦", "🇹🇩", "🇨🇰", "🇮🇨", "🇨🇽", "🇵🇫", "🇬🇱", "🇯🇴", "🇱🇧", "🇵🇼", "🇺🇬", "🇺🇦"]
    private (set) var pickedEmojis: Array<String>
    
    init(color: String, name: String, numberOfCards: Int) {
        self.numberOfCards = numberOfCards
        self.name = name
        self.color = color
        
        switch name {
        case chosenTheme.food.rawValue:
            self.pickedEmojis = Array(allEmojis[0...0 + numberOfCards])
        case chosenTheme.sport.rawValue:
            self.pickedEmojis = Array(allEmojis[18...18 + numberOfCards])
        case chosenTheme.flags.rawValue:
            self.pickedEmojis = Array(allEmojis[36...36 + numberOfCards])
        default:
            self.pickedEmojis = Array(allEmojis[0...0 + numberOfCards])
        }
    }
}
