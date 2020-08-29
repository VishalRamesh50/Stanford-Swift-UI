//
//  SetGameModel.swift
//  Set Game
//
//  Created by Vishal Ramesh on 8/24/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation
import SwiftUI

struct SetGameModel {
    private(set) var deck: Array<Card>
    private(set) var dealtCards: Array<Card> = Array<Card>()
    
    init() {
        var deck: Array<Card> = Array<Card>()
        for shape in SetShape.allCases {
            for shading in SetShading.allCases {
                for color in SetColor.allCases {
                    for numShape in 1...3 {
                        deck.append(Card(numShapes: numShape, shape: shape, shading: shading, color: color, id: deck.count)!)
                    }
                }
            }
        }
        self.deck = deck.shuffled()
    }
    
    mutating func deal() {
        self.dealtCards.append(self.deck.remove(at: 0))
    }
    
    mutating func tap(card: Card) {
        // if the initial deal hasn't been completed don't let users select cards
        if self.dealtCards.count < 12 {
            return
        }
        
        // toggle the select state of the given card
        let cardIndex = self.dealtCards.firstIndex(matching: card)!
        self.dealtCards[cardIndex].isSelected.toggle()
        let selectedCards: Array<Card> = self.dealtCards.filter { $0.isSelected }
        
        // if the card selected was the 4th one, unselect all the cards except
        // the most recently selected card
        if selectedCards.count == 4 {
            for i in 0...3 {
                let index = self.dealtCards.firstIndex(matching: selectedCards[i])!
                if self.dealtCards[index].id != self.dealtCards[cardIndex].id {
                    self.dealtCards[index].isSelected = false
                    // FIXME: Only replace these cards when they are a valid match
                    self.dealtCards[index] = self.deck.remove(at: 0)
                }
            }
        }
    }
}

struct Card: Identifiable {
    let id: Int
    let numShapes: Int
    let shape: SetShape
    let shading: SetShading
    let color: SetColor
    var isSelected: Bool = false
    
    init?(numShapes: Int, shape: SetShape, shading: SetShading, color: SetColor, id: Int) {
        if !(1...3 ~= numShapes) {
            return nil
        }
        self.numShapes = numShapes
        self.shape = shape
        self.shading = shading
        self.color = color
        self.id = id
    }
}

enum SetShape: CaseIterable {
    case diamond, squiggle, oval
}

enum SetShading: CaseIterable {
    case solid, striped, open
}

enum SetColor: CaseIterable {
    case red, green, purple
}

extension Color {
    static func from(setColor: SetColor) -> Color {
        switch setColor {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
}
