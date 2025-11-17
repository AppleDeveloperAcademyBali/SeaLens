//
//  ThumbnailView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 17/11/2025.
//

import SwiftUI

struct ThumbnailView: View {

    let image: FishImage
    let isSelected: Bool

    var body: some View {

        let borderColor: Color = isSelected ? .accentColor : .clear

        Group {
            if let url = URL(string: image.url),
               let nsImage = NSImage(contentsOf: url) {


                Image(nsImage: nsImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(borderColor, lineWidth: 3)
                    )
            }
        }
    }
}
