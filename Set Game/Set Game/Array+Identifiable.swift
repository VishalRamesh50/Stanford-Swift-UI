//
//  Array+Identifiable.swift
//  Set Game
//
//  Created by Vishal Ramesh on 8/19/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
