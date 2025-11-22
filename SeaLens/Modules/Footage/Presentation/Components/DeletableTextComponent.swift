//
//  DeletableText.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct DeletableTextComponent: View {
    var text: String = "Hello, World!"
    @MainActor var onDelete: () -> Void = { }
    
    var body: some View {
        HStack (alignment: .center) {
            Text(text)
                .textstyles(.bodyRegular)
                .padding(.leading, 4)
                
            Button {
                onDelete()
            } label: {
                Image(systemName: "xmark")
                    .padding(.vertical, 2)
                    .padding(.horizontal, -4)
            }
            .buttonStyle(.automatic)
            .clipShape(RoundedRectangle(cornerRadius: 4))

        }
        .padding(4)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.gray)
                .opacity(0.5)
        }
    }
}

#Preview {
    DeletableTextComponent()
}
