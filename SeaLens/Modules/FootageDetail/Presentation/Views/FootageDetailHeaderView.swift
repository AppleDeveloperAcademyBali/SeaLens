//
//  FootageDetailHeaderView.swift
//  SeaLens
//
//  Created by Handy Handy on 16/11/25.
//
import SwiftUI


struct FootageDetailHeaderView: View {
    @ObservedObject var footageDetailViewModel: FootageDetailViewModel
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 4) {
                HStack {
                    Text(footageDetailViewModel.getTitle())
                        .textstyles(.title1Emphasized)
                    
                    Button {
                        print("Pop Up Info")
                    } label: {
                        Image(systemName: "info.circle")
                            .textstyles(.bodyRegular)
                            
                    }
                    .glassEffect()
                    .clipShape(Circle())
                }
                
                FootageDetailSubtitleComponent(
                    totalFish: footageDetailViewModel.totalFish,
                    totalPhotos: footageDetailViewModel.totalPhotos
                )
            }
            
            Spacer()
            
            VStack (alignment: .trailing, spacing: 10) {
                
                
                HStack {
                    SearchBar(searchText: $footageDetailViewModel.searchText)

                    Menu {
                        Text("Sort By")
                        Divider()
                        
                        Section("Date Taken") {
                            Button("Newest") {
                                footageDetailViewModel.applySorting(sortOption: .dateTakenNewest)
                            }
                            Button("Oldest") {
                                footageDetailViewModel.applySorting(sortOption: .dateTakenOldest)
                            }
                        }
                        
                        Section("Filename"){
                            Button("Alphabetically (A-Z)") {
                                footageDetailViewModel.applySorting(sortOption: .filenameAscending)
                            }
                            Button("Alphabetically (Z-A)") {
                                footageDetailViewModel.applySorting(sortOption: .filenameDesscending)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(8)
                            .clipShape(.circle)
                            
                    }
                    .buttonStyle(.plain)
                    .glassEffect()
                    .padding(.leading, 8)
                }
                .offset(y: -7)
                
            }

        }
    }
}

