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
    private var selectedCards: Array<Card> {
        self.dealtCards.filter { $0.isSelected }
    }
    
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
        self.dealtCards.append(self.deck.removeLast())
    }
    
    mutating func tap(card: Card) {
        // if the initial deal hasn't been completed don't let users select cards
        if self.dealtCards.count < 12 && !self.deck.isEmpty {
            return
        }
        
        // if 3 cards have already been selected, don't allow deselection
        if selectedCards.count == 3, let _ = selectedCards.firstIndex(matching: card) {
            return
        }
        
        // toggle the select state of the given card
        self.dealtCards[self.dealtCards.firstIndex(matching: card)!].isSelected.toggle()
        
        // determine if the 3 selected cards were a match or not
        if selectedCards.count == 3 {
            for selectedCard in selectedCards {
                let sameNumShapes = selectedCards.filter { $0.numShapes == selectedCard.numShapes }
                let sameShape = selectedCards.filter { $0.shape == selectedCard.shape }
                let sameShading = selectedCards.filter { $0.shading == selectedCard.shading }
                let sameColor = selectedCards.filter { $0.color == selectedCard.color }
                let isMatch = sameNumShapes.count != 2 && sameShape.count != 2 && sameShading.count != 2 && sameColor.count != 2
                for selectedCard in selectedCards {
                    self.dealtCards[self.dealtCards.firstIndex(matching: selectedCard)!].isMatched = isMatch
                }
                if !isMatch {
                    return
                }
            }
        }
        
        // If the card selected was the 4th one, unselect all the cards except the
        // most recently selected card. Replace cards that were a match with cards
        // from the deck if the deck isn't empty. Revert the matched state if they were not.
        if selectedCards.count == 4 {
            for cardToUnselect in selectedCards {
                if cardToUnselect.id == card.id {
                    continue
                }
                
                let dealtIndex = self.dealtCards.firstIndex(matching: cardToUnselect)!
                self.dealtCards[dealtIndex].isSelected = false
                if self.dealtCards[dealtIndex].isMatched! {
                    if self.deck.isEmpty {
                        self.dealtCards.remove(at: dealtIndex)
                    } else {
                        self.dealtCards[dealtIndex] = self.deck.removeLast()
                    }
                } else {
                    self.dealtCards[dealtIndex].isMatched = nil
                }
            }
        }
    }
    
    mutating func deal3More() {
        let matchedAndSelected = selectedCards.filter { $0.isMatched ?? false }
        if matchedAndSelected.count == 3 {
            for card in matchedAndSelected {
                self.dealtCards[self.dealtCards.firstIndex(matching: card)!] = self.deck.removeLast()
            }
        } else {
            for _ in 1...3 {
                self.deal()
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
    var isMatched: Bool?
    
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
