//
//  RecentUploadsView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI

public struct RecentUploadsPresentation: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var recentUploadsViewModel = RecentUploadsViewModel()
    //
    @State var selectedFootageUID: Set<UUID> = []
    
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
                            .simultaneousGesture(TapGesture().onEnded { router.selectedFootage(footage.uid) })
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 100)
                }
            }
            
            Button {
                router.showingUploadFootage()
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
            await recentUploadsViewModel.loadFootages(footagesUidList: selectedFootageUID)
        }
        .onChange(of: recentUploadsViewModel.searchText) { _ , _ in
            recentUploadsViewModel.applySearching(searchText: recentUploadsViewModel.searchText)
        }
        .onChange(of: router.newFootageUid) { _, newValue in
            guard router.newFootageUid != nil else { return }
            Task {
                await recentUploadsViewModel.loadFootages(footagesUidList: selectedFootageUID)
            }
        }
    }
}

struct EmptyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
