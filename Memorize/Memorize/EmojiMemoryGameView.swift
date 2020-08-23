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
        VStack {
            Text(viewModel.themeName).font(.title)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }.padding(5)
            }
            HStack {
                NewGameButton
                Spacer()
                Score
            }.padding(.horizontal, 10)
        }.padding()
    }
    
    private var NewGameButton: some View {
        Button(action: {
            self.viewModel.newGame()
        }, label: {
            Text("NEW GAME")
                .padding(10)
                .padding(.horizontal, 10)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(30)
        })
    }
    
    private var Score: some View {
        Text("(Score: \(viewModel.score))").font(.body)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Pie(startAngle: Angle.degrees(0-90), endAngle:Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
            }
            else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .foregroundColor(Color.fromThemeColor(color: card.color))
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
