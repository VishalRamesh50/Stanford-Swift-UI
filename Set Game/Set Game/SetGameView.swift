//
//  SetGameView.swift
//  Set Game
//
//  Created by Vishal Ramesh on 8/24/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel

    var body: some View {
        withAnimation(.easeInOut(duration: 2)) {
            Grid(viewModel.dealtCards) { card in
                CardView(card: card)
            }
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        let shape: String = String(reflecting: card.shape).components(separatedBy: ".")[2]
        let shading: String = String(reflecting: card.shading).components(separatedBy: ".")[2]
        let color: Color = Color.from(setColor: card.color)
        return ZStack {
            RoundedRectangle(cornerRadius: 20).fill(color).opacity(card.shading == SetShading.open ? 0 : 1)
            Text("ID: \(card.id)\n# of Shapes: \(card.numShapes)\nShape: \(shape)\nShading: \(shading)").font(Font.body)
        }.transition(AnyTransition.scale)
    }
}

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
