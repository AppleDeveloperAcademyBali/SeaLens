//
//  FootageDetailSubtitleComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 18/11/25.
//

import SwiftUI

struct FootageDetailSubtitleComponent: View {
    var totalFish: Int = 0
    var totalPhotos: Int = 3
    var body: some View {
        VStack (alignment: .leading) {
            HStack {  // Reduced spacing
                HStack(spacing: 4) {
                    Image(systemName: "fish")
                    Text("\(totalFish) counted")
                }
                Text("•")
                HStack(spacing: 4) {
                    Image(systemName: "photo.on.rectangle.angled")
                    let photo = (totalPhotos) > 1 ? "photos" : "photo"
                    Text("\(totalPhotos) \(photo)")
                }
            }
            .textstyles(.bodyRegular)
            .foregroundColor(.gray)
            
            let clampedProgress = min(max(0.3, 0), 1)
            ProgressView(value: clampedProgress)
                .progressViewStyle(.linear)
                .frame(width: 220)
        }
    }
}

#Preview {
    FootageDetailSubtitleComponent()
        .padding()
}
