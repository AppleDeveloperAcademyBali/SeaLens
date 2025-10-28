//
//  RecentUploadsView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI
import SwiftData

public struct RecentUploadsPresentation: View {
    @Environment(\.modelContext) private var modelContext
    @State private var recentUploadsViewModel: RecentUploadsViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    
    init(modelContext: ModelContext) {
        self.recentUploadsViewModel = RecentUploadsViewModel(modelContext: modelContext)
    }
    
    public var body: some View  {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(recentUploadsViewModel.recentUploads) { upload in
                            NavigationLink {
                                //UploadCompleteView
                            } label: {
                                Folder(title: upload.filename) {
                                    //Code when folder is tapped
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Recent Uploads")
        .onAppear() {
            recentUploadsViewModel.fetchRecentUploads()
        }
    }
}
