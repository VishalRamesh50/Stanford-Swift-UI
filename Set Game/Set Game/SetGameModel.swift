//
//  SetGameModel.swift
//  Set Game
//
//  Created by Vishal Ramesh on 8/24/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation

struct SetGameModel {
    private(set) var deck: Array<Card>
    private(set) var dealtCards: Array<Card> = Array<Card>()
    
    init() {
        var deck: Array<Card> = Array<Card>()
        for shape in SetShape.allCases {
            for shading in SetShading.allCases {
                for color in SetColor.allCases {
                    for numShape in 1...3 {
                        deck.append(Card(numShapes: numShape, shape: shape, shading: shading, color: color)!)
                    }
                }
            }
        }
        self.deck = deck.shuffled()
    }
}

struct Card {
    let numShapes: Int
    let shape: SetShape
    let shading: SetShading
    let color: SetColor
    var isSelected: Bool = false
    
    init?(numShapes: Int, shape: SetShape, shading: SetShading, color: SetColor) {
        if !(1...3 ~= numShapes) {
            return nil
        }
        self.numShapes = numShapes
        self.shape = shape
        self.shading = shading
        self.color = color
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
