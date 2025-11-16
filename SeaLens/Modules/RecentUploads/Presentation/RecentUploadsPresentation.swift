//
//  RecentUploadsView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI

public struct RecentUploadsPresentation: View {
    @StateObject private var recentUploadsViewModel = RecentUploadsViewModel()
    @ObservedObject var initialNavigationViewModel: InitialNavigationViewModel
    
    public var body: some View  {
        NavigationStack {
            ZStack (alignment: .bottom) {
                VStack(alignment: .leading) {
                    RecentUploadHeaderView(recentUploadsViewModel: recentUploadsViewModel)
                        .padding()
                    
                    ScrollView {
                        FlowHStack {
                            ForEach(recentUploadsViewModel.footages) { footage in
                                NavigationLink(value: footage) {
                                    FootageFolder(title: footage.filename)
                                        .frame(width: 285, height: 170)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .padding(.leading)
                }
                
                Button {
                    initialNavigationViewModel.showingUploadFootage()
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
            .navigationDestination(for: Footage.self) { footage in
                FootageDetailPresentation()
            }
        }
        .task {
            await recentUploadsViewModel.loadFootages()
        }
        .onChange(of: recentUploadsViewModel.searchText) { _ , _ in
            recentUploadsViewModel.applySearching(searchText: recentUploadsViewModel.searchText)
        }
    }
}
