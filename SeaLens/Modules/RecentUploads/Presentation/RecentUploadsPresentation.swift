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
    
    let columns = [
        GridItem(.adaptive(minimum: 250))
    ]
    
    public var body: some View  {
        ZStack (alignment: .bottom) {
            VStack(alignment: .leading) {
                RecentUploadHeaderView(recentUploadsViewModel: recentUploadsViewModel)
                //
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(recentUploadsViewModel.footages) { footage in
                            NavigationLink(value: footage.uid.uuidString) {
                                FootageFolder(title: footage.filename)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(HoverPressButtonStyle())
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 100)
                }
            }
            
            Button {
                initialNavigationViewModel.showingUploadFootage()
            } label: {
                Label("Upload Video", systemImage: "arrow.up.circle")
                    .frame(width: 200)
                    .padding(.vertical, 8)
            }
            .clipShape(Capsule())
            .glassEffect(.regular.tint(.blue.opacity(0.45)).interactive())
            .padding(.bottom, 30)
        }
        .padding()
        .task {
            await recentUploadsViewModel.loadFootages()
        }
        .onChange(of: recentUploadsViewModel.searchText) { _ , _ in
            recentUploadsViewModel.applySearching(searchText: recentUploadsViewModel.searchText)
        }
        .onChange(of: initialNavigationViewModel.newFootageUid) { _, newValue in
            guard initialNavigationViewModel.newFootageUid != nil else { return }
            Task {
                await recentUploadsViewModel.loadFootages()
            }
        }
    }
}

struct EmptyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
