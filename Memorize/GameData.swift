//
//  GameData.swift
//  Memorize
//
//  Created by Georg Boehm on 13.12.22.
//

import Foundation

struct memoryGameData {
    private (set) var allEmojis = [
        ["🌯", "🍫", "🍭", "🍞", "🥨", "🍙", "🥕", "🧀", "🍔","🍖", "🥚", "🥩", "🥗", "🥠", "🍩", "🍡", "🍣", "🌭"],
        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏒", "🪃", "🥊", "🤿", "🥌", "🎣", "⛷"],
        ["🏳️", "🏴‍☠️", "🏳️‍🌈", "🚩", "🇦🇹", "🇨🇦", "🇹🇩", "🇨🇰", "🇮🇨", "🇨🇽", "🇵🇫", "🇬🇱", "🇯🇴", "🇱🇧", "🇵🇼", "🇺🇬", "🇺🇦"]]
    private (set) var colors = ["red", "orange", "blue", "purple", "green", "yellow"]
    private (set) var numberOfPairs = [4, 5, 6, 8]
    
    func selectRandomTheme() -> Theme {
        let color = colors.randomElement() ?? colors[0]
        let emojis = allEmojis.randomElement() ?? allEmojis[0]
        let numberOfPairs = numberOfPairs.randomElement() ?? numberOfPairs[0]
        let randomTheme = Theme(color: color, numberOfCards: numberOfPairs, emojis: emojis)
        return randomTheme
    }
}

