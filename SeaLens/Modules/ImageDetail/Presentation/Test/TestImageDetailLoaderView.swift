//
//  TestImageDetailLoaderView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 17/11/2025.
//

import SwiftUI
import SwiftData

struct TestImageDetailLoaderView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var images: [FishImage]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                if let firstImage = images.first {
                    Text("Loaded First FishImage: \(firstImage.uid.uuidString)")
                        .font(.caption)

                    NavigationLink("Open Image Detail") {
                        ImageDetailPresentation(fishImageUID: firstImage.uid)
                    }

                } else {
                    Text("No FishImage found in database.")
                    Text("Go to Mock Data → Generate Dummy Data")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}
