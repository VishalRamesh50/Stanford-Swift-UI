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
        Grid(self.viewModel.dealtCards) { card in
            CardView(card: card).onTapGesture {
                self.viewModel.tap(card: card)
            }
        }.onAppear {
            var count = 0
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ t in
                if count == 11 {
                    t.invalidate()
                }
                withAnimation(Animation.easeInOut) {
                    self.viewModel.deal()
                }
                count += 1
            }
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        let shape: String = String(reflecting: card.shape).components(separatedBy: ".")[2]
        let shading: String = String(reflecting: card.shading).components(separatedBy: ".")[2]
        return ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                    .shadow(radius: card.isSelected ? 0 : shadowRadius)
                    .animation(.spring())
                if card.isSelected {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(Color.yellow, lineWidth: 3)
                }
            }
            GeometryReader { geometry in
                VStack {
                    ForEach(0..<self.card.numShapes) { _ in
                        Oval(size: geometry.size, shading: self.card.shading, color: self.card.color)
                    }
                }
            }
            Text("ID: \(card.id)\nShape: \(shape)\nShading: \(shading)").font(Font.body)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .transition(AnyTransition.scale)
        .padding(3)
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 10
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
