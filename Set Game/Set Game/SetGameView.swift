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
        VStack {
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
            Deal3MoreButton
        }
    }
    
    private var Deal3MoreButton: some View {
        let isDisabled: Bool  = self.viewModel.isDeckEmpty
        return Button(action: {
            self.viewModel.deal3More()
        }, label: {
            Text("Deal 3 More")
                .padding(10)
                .padding(.horizontal, 10)
                .background(isDisabled ? Color.gray : Color.pink)
                .foregroundColor(Color.white)
                .cornerRadius(30)
        }).disabled(isDisabled)
    }
}

struct CardView: View {
    var card: Card
    @State private var offsetX: CGFloat = CGFloat.random(in: -1000...1000)
    @State private var offsetY: CGFloat = CGFloat.random(in: -1000...1000)
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        return ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colorScheme == .dark ? Color(UIColor.systemGray5) : Color.white)
                    .shadow(radius: card.isSelected ? 0 : shadowRadius)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(strokeColor, lineWidth: lineWidth)
            }
            GeometryReader { geometry in
                VStack {
                    ForEach(0..<self.card.numShapes) { _ in
                        CardShape(size: geometry.size, card: self.card)
                    }
                }
            }
        }
            .aspectRatio(2/3, contentMode: .fit)
            .offset(x: offsetX, y: offsetY)
            .padding(3)
            .animation(.spring())
            .transition(.offset(x: CGFloat.random(in: -5000...5000), y: CGFloat.random(in: -5000...5000)))
            .onAppear() {
                self.offsetX = 0
                self.offsetY = 0
            }
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 10
    var strokeColor: Color {
        if card.isSelected {
            if let isMatched = card.isMatched {
                return isMatched ? Color.green : Color.red
            } else {
                return Color.yellow
            }
        } else {
            return Color.white
        }
    }
    var lineWidth: CGFloat { strokeColor == Color.white ? 1 : 3 }
}

struct CardShape: View {
    let size: CGSize
    let card: Card
    
    var body: some View {
        return VStack {
            if card.shape == .squiggle { body(shape: Rectangle()) }
            else if card.shape == .diamond { body(shape: Diamond()) }
            else if card.shape == .oval { body(shape: Capsule()) }
        }
    }
    
    private func body<T: Shape>(shape: T) -> some View {
        ZStack {
            shape
                .stroke(Color.from(setColor: card.color), lineWidth: 2)
                .frame(width: width, height: height)
                .padding(.vertical, 5)
            if card.shading != .open {
                shape
                    .fill(Color.from(setColor: card.color).opacity(card.shading == .striped ? openOpacity: 1))
                    .frame(width: width, height: height)
            }
        }
    }
    
    // MARK: - Drawing Constants
    var width: CGFloat { size.width * 0.7 }
    var height: CGFloat { size.height * 0.2 }
    let openOpacity: Double = 0.3
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.midY))
        return p
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
