//
//  ContentView.swift
//  Memorize
//
//  Created by Georg Boehm on 09.12.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
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
                        CardView(card: card, color: viewModel.getThemeColor()).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
        }
    }
    var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            Image(systemName: "house").font(.largeTitle)
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color

    var body: some View {
        return ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if card.isFaceUp {
                shape
                    .fill(color)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0) // Card becomes transparent
            } else {
                shape
                    .fill(color)
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
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
