//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Georg Boehm on 09.12.22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
