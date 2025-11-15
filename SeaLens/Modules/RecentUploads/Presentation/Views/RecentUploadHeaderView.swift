//
//  RecentUploadHeader.swift
//  SeaLens
//
//  Created by Handy Handy on 15/11/25.
//

import SwiftUI

struct RecentUploadHeaderView: View {
    @ObservedObject var recentUploadsViewModel: RecentUploadsViewModel
    
    @Binding var searchText: String
    
    var body: some View {
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
    }
}
