//
//  Theme.swift
//  Memorize
//
//  Created by Georg Boehm on 12.12.22.
//

import Foundation

struct Theme {
    private (set) var numberOfCards: Int
    private (set) var color: String
    private (set) var pickedEmojis: Array<String>
    
    init(color: String, numberOfCards: Int, emojis: Array<String>) {
        self.numberOfCards = numberOfCards
        self.color = color
        self.pickedEmojis = emojis
    }
}
