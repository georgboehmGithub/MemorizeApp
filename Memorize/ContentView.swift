//
//  ContentView.swift
//  Memorize
//
//  Created by Georg Boehm on 09.12.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
//    @State var emojis = ["🌯", "🍫", "🍭", "🍞", "🥨", "🍙", "🥕", "🧀", "🍔","🍖", "🥚", "🥩", "🥗", "🥠", "🍩", "🍡", "🍣", "🌭"]
    @State var homeScreen = false
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("Memorize!").font(.largeTitle)
                    newGame
                }
                Spacer()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach (viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                let _ = print("PICKED CARD!")
                                viewModel.choose(card)
                            }
                    }
                }
            }
        }
    }
    var newGame: some View {
        Button {
            viewModel.rollTheme()
        } label: {
            Image(systemName: "house").font(.largeTitle)
        }
    }
}

// TODO PASS THEME COLOR
struct CardView: View {
    let card: MemoryGame<String>.Card
    // TODO: let color: String

    var body: some View {
        return ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if card.isFaceUp {
                shape
                    .fill(.red)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0) // Card becomes transparent
            } else {
                shape
                    .fill(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
