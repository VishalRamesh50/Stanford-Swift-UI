//
//  Grid.swift
//  Memorize
//
//  Created by Vishal Ramesh on 8/19/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) { 
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
