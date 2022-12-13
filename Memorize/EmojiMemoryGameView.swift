//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Georg Boehm on 09.12.22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
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
                    ForEach (game.cards) { card in
                        CardView(card: card, color: game.getThemeColor()).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
        }
    }
    var newGame: some View {
        Button {
            game.newGame()
        } label: {
            Image(systemName: "house").font(.largeTitle)
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let color: Color

    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape
                        .fill(color)
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0) // Card becomes transparent
                } else {
                    shape
                        .fill(color)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
