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
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
