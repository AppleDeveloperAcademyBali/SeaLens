//
//  VideoTag.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 7/11/2025.
//


import SwiftUI

struct VideoTag: View {
    
    var fileName: String
    
    var body: some View {
        
        HStack(spacing: 6) {
            Text(fileName)
                .foregroundStyle(.black)
            
            Image(systemName: "info.circle")
                .textstyles(.title3Medium)
                .foregroundStyle(.blue)
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .stroke(Color.black, lineWidth: 1)
        )
            
    }
}

#Preview {
    VideoTag(fileName: "Bali-Dec-2025")
}
