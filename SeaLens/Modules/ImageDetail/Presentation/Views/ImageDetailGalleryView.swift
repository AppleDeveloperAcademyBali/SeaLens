//
//  ImageDetailGalleryView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 17/11/2025.
//

import SwiftUI

struct ImageDetailGalleryView: View {

    @ObservedObject var vm: ImageDetailViewModel

    var body: some View {
        VStack(spacing: 16) {

            // MARK: Selected Image
            if let selected = vm.selectedImage,
               let url = URL(string: selected.url),
               let nsImage = NSImage(contentsOf: url) {

                Image(nsImage: nsImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .animation(.easeInOut, value: selected.uid)
            }

            // MARK: Thumbnails
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(vm.images, id: \.uid) { img in

                        let selected = vm.selectedImage?.uid == img.uid

                        ThumbnailView(image: img, isSelected: selected)
                            .onTapGesture {
                                withAnimation {
                                    vm.selectedImage = img
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }

            // MARK: Bottom Bar
            HStack(spacing: 20) {

                Button {
                    // TODO: open assign sheet
                } label: {
                    Label("Assign to a family/species", systemImage: "square.and.pencil")
                }

                Spacer()

                Button {
                    // TODO: favorite
                } label: {
                    Image(systemName: "heart")
                }

                Button {
                    // TODO: delete
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
            }
            .padding(.horizontal)

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(NSColor.windowBackgroundColor))
        )
        .padding(.horizontal)
    }
}
