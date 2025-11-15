//
//  ReviewFishPresentation.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct ReviewFishPresentation: View {
    @Binding var isShowingSheet: Bool
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                NavigationFishCountView {
                    isShowingSheet.toggle()
                }
                .padding()
                FishFamiliesListView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: 360, maxHeight: .infinity)
            .glassEffect(in: .rect(cornerRadius: 16.0))
            .padding()
            
            AnnotatedVideoView()
                .padding(.vertical)
                .padding(.trailing)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ReviewFishPresentation(isShowingSheet: .constant(true))
}
