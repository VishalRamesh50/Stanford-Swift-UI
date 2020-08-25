//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Vishal Ramesh on 8/24/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation

class SetGameViewModel: ObservableObject {
    @Published private var model: SetGameModel = SetGameModel()
    
    var dealtCards: Array<Card> {
        model.dealtCards
    }
}
