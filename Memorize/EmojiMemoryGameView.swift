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
            HStack {
                Text("Memorize!").font(.largeTitle)
                newGame
            }
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card, color: game.getThemeColor())
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            })
            Text("Score: \(game.score)").font(.largeTitle)
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
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.piePadding).opacity(DrawingConstants.pieOpacity).foregroundColor(.red)
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let piePadding: CGFloat = 5
        static let pieOpacity: CGFloat = 0.35
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
