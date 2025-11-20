//
//  FishFamiliesListView.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct FishFamiliesListView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            ForEach( 1...12 , id: \.self) { _ in
                ReviewFishComponent()
                    .padding(.bottom, 16)
            }
        }
        .frame(width: 360)
        //        .listStyle(.insetGrouped)
    }
}

#Preview {
    FishFamiliesListView()
}
