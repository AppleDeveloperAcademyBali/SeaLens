//
//  RecentUploadsView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI
import SwiftData
import Foundation
import AppKit

public struct RecentUploadsPresentation: View {
    @StateObject private var recentUploadsViewModel = RecentUploadsViewModel()
    
    public var body: some View  {
        NavigationStack {
            ZStack (alignment: .bottom) {
                VStack(alignment: .leading) {
                    RecentUploadHeaderView(recentUploadsViewModel: recentUploadsViewModel, searchText: $recentUploadsViewModel.searchText)
                        .padding()
                    
                    ScrollView {
                        FlowHStack {
                            ForEach(recentUploadsViewModel.footages) { upload in
                                FootageFolder(destination: FishCollectionView(), title: upload.filename)
                                    .frame(width: 285, height: 170)
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .padding(.leading)
                }
                
                Button {
                    print("Dismissed")
                } label: {
                    Label("Upload Video", systemImage: "arrow.up.circle")
                        .frame(width: 200)
                        .padding(.vertical, 8)
                }
                .clipShape(Capsule())
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 30)
                

            }
            .padding()
        }
        .task {
            await recentUploadsViewModel.loadFootages()
        }
        .onChange(of: recentUploadsViewModel.searchText) { _ , _ in
            recentUploadsViewModel.applySearching(searchText: recentUploadsViewModel.searchText)
        }
    }
}
