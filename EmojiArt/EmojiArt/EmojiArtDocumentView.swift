//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Vishal Ramesh on 8/31/20.
//  Copyright © 2020 Vishal Ramesh. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument

    var body: some View {
        HStack {
            ForEach(EmojiArtDocument.palette.map { String($0) }) { emoji in
                Text(emoji)
            }
        }
    }
}

extension String: Identifiable {
    public var id: String { return self }
}
