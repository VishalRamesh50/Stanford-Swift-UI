//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Vishal Ramesh on 6/28/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let themes = [
            MemoryGameTheme(name: "Halloween", emojis: ["👻","🎃", "🕷", "🕸", "🦇", "☠️"], pairs: 3, color: ThemeColor.orange),
            MemoryGameTheme(name: "Sports", emojis: ["⚽️","🥎", "🏸", "🎱", "🏀"], pairs: 4, color: ThemeColor.red),
            MemoryGameTheme(name: "Animals", emojis: ["🐶","🐼", "🦄", "🐯", "🐮"], pairs: 5, color: ThemeColor.pink),
            MemoryGameTheme(name: "Faces", emojis: ["😎","😅", "😉", "😤", "🤑"], pairs: nil, color: ThemeColor.yellow),
            MemoryGameTheme(name: "Transportation", emojis: ["🚗","🛺", "✈️", "🏎", "🛳"], pairs: nil, color: ThemeColor.green),
            MemoryGameTheme(name: "Instruments", emojis: ["🎹","🥁", "🎺", "🎸", "🎻"], pairs: 3, color: ThemeColor.blue)
        ]
        let theme = themes.randomElement()!
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(themeName: theme.name, numberOfPairsOfCards: theme.pairs ?? Int.random(in: 2...5), color: theme.color) { pairIndex in
            return shuffledEmojis[pairIndex % shuffledEmojis.count]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.themeName
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
