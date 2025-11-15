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
    
    init(modelContext: ModelContext) {
        _recentUploadsViewModel = StateObject(wrappedValue: RecentUploadsViewModel(modelContext: modelContext))
    }
    
    public var body: some View  {
        NavigationStack {
            GeometryReader{ geometry in
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading){
                            Text("Recent Observations")
                                .textstyles(.title1Emphasized)
                                .padding(.bottom, 2)
                            Text("􀉁 \(recentUploadsViewModel.footages.count) observations")
                                .textstyles(.title3Regular)
                                .foregroundColor(.secondary)
                                .italic()
                        }
                        .padding(.bottom, 10)
                        
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
                    .padding()
                    
                    ScrollView {
                        FlowHStack {
                            ForEach(recentUploadsViewModel.footages) { upload in
                                FootageFolder(destination: FishCollectionView(), title: upload.filename)
                                    .frame(width: 285, height: 170)
                            }
                        }
                    }
                }
                .padding()
                
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
