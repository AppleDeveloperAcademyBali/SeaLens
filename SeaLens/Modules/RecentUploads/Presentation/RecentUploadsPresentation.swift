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
    @Environment(\.modelContext) private var modelContext
    @StateObject private var recentUploadsViewModel: RecentUploadsViewModel
    
    @State private var searchText: String = ""
    @Binding var isUploadFormPresented: Bool
    
    init(modelContext: ModelContext, isUploadFormPresented: Binding<Bool>) {
        _recentUploadsViewModel = StateObject(wrappedValue: RecentUploadsViewModel(modelContext: modelContext))
        _isUploadFormPresented = isUploadFormPresented
    }
    
    public var body: some View  {
        NavigationStack {
            ZStack (alignment: .bottom) {
                VStack(alignment: .leading) {
                    RecentUploadHeaderView(recentUploadsViewModel: recentUploadsViewModel, searchText: $searchText)
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
                    isUploadFormPresented.toggle()
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
        .onChange(of: searchText) { _ , _ in
            recentUploadsViewModel.applySearching(searchText: searchText)
        }
    }
}
