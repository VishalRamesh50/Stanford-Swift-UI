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
                CardView(card: card).aspectRatio(2/3, contentMode: .fit)
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

struct Oval: View {
    let size: CGSize
    let shading: SetShading
    let color: SetColor
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(Color.from(setColor: color))
                .frame(width: width, height: height)
                .padding(.vertical, 5)
            if shading != .open {
                Capsule()
                    .fill(Color.from(setColor: color).opacity(shading == .striped ? openOpacity: 1))
                    .frame(width: width, height: height)
            }
        }
    }
    
    // MARK: - Drawing Constants
    var width: CGFloat { size.width * 0.7 }
    var height: CGFloat { size.height * 0.2 }
    let openOpacity: Double = 0.3
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
