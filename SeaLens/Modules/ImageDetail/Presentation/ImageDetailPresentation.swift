//
//  ImageDetailPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/11/2025.
//


import SwiftUI
import SwiftData

struct ImageDetailPresentation: View {

    @StateObject var vm: ImageDetailViewModel

    init(fishImageUID: UUID) {
        _vm = StateObject(wrappedValue: ImageDetailViewModel(fishImageUID: fishImageUID))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            ImageDetailHeaderView(vm: vm)

            ImageDetailGalleryView(vm: vm)

            Spacer()
        }
        .padding()
    }
}

