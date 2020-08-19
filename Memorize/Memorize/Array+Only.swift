//
//  Array+Only.swift
//  Memorize
//
//  Created by Vishal Ramesh on 8/19/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
