//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Vishal Ramesh on 6/28/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .aspectRatio(2/3, contentMode: .fit)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader {geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                    Text(self.card.content)
                }
                else {
                    RoundedRectangle(cornerRadius: 10.0).fill()
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.75))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame()).colorScheme(.light)
            EmojiMemoryGameView(viewModel: EmojiMemoryGame()).colorScheme(.dark)
        }
    }
}
