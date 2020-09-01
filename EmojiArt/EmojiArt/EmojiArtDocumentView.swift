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
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                    }
                }
            }
            .padding(.horizontal)
            Rectangle()
                .foregroundColor(.yellow)
                .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
    }
    
    private let defaultEmojiSize: CGFloat = 40
}
