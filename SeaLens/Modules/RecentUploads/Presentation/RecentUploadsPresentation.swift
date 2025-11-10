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
    @State private var filteredFootages: [Footage] = []
    
    init(modelContext: ModelContext) {
        _recentUploadsViewModel = StateObject(wrappedValue: RecentUploadsViewModel(modelContext: modelContext))
    }
    
    public var body: some View  {
        NavigationStack {
            GeometryReader{ geometry in
                ZStack {
                    VStack(alignment: .leading) {
                        HStack() {
                            Text("Recent Uploads")
                                .textstyles(.title1Emphasized)
                            
                            Spacer()
                            
                            HStack() {
                                
                                SearchBar(searchText: $searchText)
                                    
                                Menu {
                                    Text("Sort By")
                                    Divider()
                                    
                                    Section("Date Taken") {
                                        Button("Newest") {
                                            recentUploadsViewModel.applySorting(sortOption: .dateTakenNewest)
                                        }
                                        Button("Oldest") {
                                            recentUploadsViewModel.applySorting(sortOption: .dateTakenOldest)
                                        }
                                    }
                                    
                                    Section("Filename"){
                                        Button("Alphabetically (A-Z)") {
                                            recentUploadsViewModel.applySorting(sortOption: .filenameAscending)
                                        }
                                        Button("Alphabetically (Z-A)") {
                                            recentUploadsViewModel.applySorting(sortOption: .filenameDesscending)
                                        }
                                    }
                                } label: {
                                    Image("iconSort")
                                        .clipShape(.circle)
                                        .frame(width: 50, height: 50)
                                        
                                }
                                .buttonStyle(.plain)

                            }
                        }
                        
                        ScrollView {
                            FlowHStack {
                                ForEach(recentUploadsViewModel.footages) { upload in
                                    FootageFolder(destination: FishCollectionView(), title: upload.filename)
                                        .frame(width: 155, height: 170)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            await recentUploadsViewModel.loadFootages()
        }
        .onChange(of: searchText) { _ , _ in
            recentUploadsViewModel.applySearching(searchText: searchText)
        }
    }
}

#Preview {
    let preview = Preview()
    preview.addExamples(Footage.sampleData)
    return RecentUploadsPresentation(
        modelContext: preview.container.mainContext)
}
