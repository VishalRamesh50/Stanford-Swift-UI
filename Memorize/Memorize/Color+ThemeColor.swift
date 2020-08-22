//
//  Color+ThemeColor.swift
//  Memorize
//
//  Created by Vishal Ramesh on 8/21/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import SwiftUI

extension Color {
    static func fromThemeColor(color: ThemeColor) -> Color {
        switch color {
        case .red:
            return Color.red
        case .orange:
            return Color.orange
        case .yellow:
            return Color.yellow
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .pink:
            return Color.pink
        }
    }
}
