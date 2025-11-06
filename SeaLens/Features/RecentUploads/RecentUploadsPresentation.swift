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
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    init(modelContext: ModelContext) {
        let persistence = RecentUploadsPersistence(modelContext: modelContext)
        self.recentUploadsViewModel = RecentUploadsViewModel(persistence: persistence)
    }
    
    public var body: some View  {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack() {
                    Text("Recent Uploads")
                        .font(.title)
                        .foregroundColor(.primary)
                        .bold()
                    
                    Spacer()
                    
                    HStack(alignment: .top, spacing: 4) {
                        Button {
                            
                        } label: {
                            Image("iconSort")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            
                        } label: {
                            Image("iconFilter")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        //TODO: change to realdata later
                        ForEach(Footage.sampleData) { upload in
                            Folder(title: upload.filename) {
                                //Code when folder is tapped
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("SeaLens")
        .onAppear() {
            recentUploadsViewModel.fetchRecentUploads()
        }
    }
}

#Preview {
    let preview = Preview()
    preview.addExamples(Footage.sampleData)
    return RecentUploadsPresentation(
        modelContext: preview.container.mainContext)
}
