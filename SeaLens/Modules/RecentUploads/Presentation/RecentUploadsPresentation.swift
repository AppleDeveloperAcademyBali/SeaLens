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
    @State private var recentUploadsViewModel: RecentUploadsViewModel
    
    @State private var searchText: String = ""
    @State private var filteredFootages: [Footage] = []
    
    init(modelContext: ModelContext) {
        self.recentUploadsViewModel = RecentUploadsViewModel(modelContext: modelContext)
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
                                            applySorting(.dateTakenNewest)
                                        }
                                        Button("Oldest") {
                                            applySorting(.dateTakenOldest)
                                        }
                                    }
                                    
                                    Section("Filename"){
                                        Button("Alphabetically (A-Z)") {
                                            applySorting(.filenameAscending)
                                        }
                                        Button("Alphabetically (Z-A)") {
                                            applySorting(.filenameDesscending)
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
                                ForEach(filteredFootages) { upload in
                                    FootageFolder(destination: UploadVideoPresentation(), title: upload.filename)
                                        .frame(width: 155, height: 170)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear() {
            filteredFootages = Footage.sampleData
        }
        .onChange(of: searchText) { _ , _ in
            applySearching()
        }
    }
    
    func applySearching() {
        if searchText.isEmpty {
            filteredFootages = Footage.sampleData
        } else {
            filteredFootages = filteredFootages.filter { $0.filename.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func applySorting(_ option: SortOption) {
        switch option {
        case .dateTakenNewest:
            filteredFootages.sort { $0.dateTaken > $1.dateTaken }
            break
        case .dateTakenOldest:
            filteredFootages.sort { $0.dateTaken < $1.dateTaken }
            break
        case .filenameAscending:
            filteredFootages.sort { $0.filename < $1.filename }
            break
        case .filenameDesscending:
            filteredFootages.sort { $0.filename > $1.filename }
            break
        }
    }
}

#Preview {
    let preview = Preview()
    preview.addExamples(Footage.sampleData)
    return RecentUploadsPresentation(
        modelContext: preview.container.mainContext)
}
