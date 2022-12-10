//
//  ContentView.swift
//  Memorize
//
//  Created by Georg Boehm on 09.12.22.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🌯", "🍫", "🍭", "🍞", "🥨", "🍙", "🥕", "🧀", "🍔","🍖", "🥚", "🥩", "🥗", "🥠", "🍩", "🍡", "🍣", "🌭"]
    @State var emojiCount = 12
    @State var homeScreen = false
    var body: some View {
        if homeScreen {
            VStack {
                ScrollView {
                    Text("Memorize!").font(.largeTitle)
                    Spacer()
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach (emojis.shuffled()[0..<emojiCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
                HStack {
                    home
                }
                .font(.largeTitle)
                .padding(.horizontal)
            }
        } else {
            VStack {
                menuView(label: "🍔", theme: "Food", color: .red)
                    .onTapGesture {
                        homeScreen = !homeScreen
                        emojiCount = 6
                        emojis = ["🌯", "🍫", "🍭", "🍞", "🥨", "🍙", "🥕", "🧀", "🍔","🍖", "🥚", "🥩", "🥗", "🥠", "🍩", "🍡", "🍣", "🌭"]
                    }
                menuView(label: "🏀", theme: "Sports", color: .green)
                    .onTapGesture {
                        homeScreen = !homeScreen
                        emojiCount = 12
                        emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏒", "🪃", "🥊", "🤿", "🥌", "🎣", "⛷"]
                    }
                menuView(label: "🏳️‍🌈", theme: "Flags", color: .blue)
                    .onTapGesture {
                        homeScreen = !homeScreen
                        emojiCount = 8
                        emojis = ["🏳️", "🏴‍☠️", "🏳️‍🌈", "🚩", "🇦🇹", "🇨🇦", "🇹🇩", "🇨🇰", "🇮🇨", "🇨🇽", "🇵🇫", "🇬🇱", "🇯🇴", "🇱🇧", "🇵🇼", "🇺🇬", "🇺🇦"]
                    }
            }
            }
        }
    var home: some View {
        Button {
            homeScreen = !homeScreen
        } label: {
            Image(systemName: "house")
        }
    }
}

struct menuView: View {
    let label: String
    let theme: String
    let color: Color
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            shape.fill(color)
            VStack {
                Text(theme).font(.largeTitle)
                Text(label).font(.largeTitle)
            }
        }.padding()
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        return ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if isFaceUp {
                shape
                    .fill(.red)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape
                    .fill(.red)
            }
        }
        //.padding()
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
