//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Vishal Ramesh on 8/21/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation

struct MemoryGameTheme {
    let name: String
    let emojis: [String]
    let pairs: Int?
    let color: ThemeColor
    
    init(name: String, emojis: [String], pairs: Int?, color: ThemeColor) {
        self.name = name
        self.emojis = emojis
        self.pairs = pairs
        self.color = color
    }
}

enum ThemeColor {
    case red, orange, yellow, green, blue, pink
}
