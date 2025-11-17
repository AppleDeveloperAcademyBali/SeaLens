//
//  FootageDetailHeaderView.swift
//  SeaLens
//
//  Created by Handy Handy on 16/11/25.
//
import SwiftUI

struct FootageDetailHeaderView: View {
    @ObservedObject var footageDetailViewModel: FootageDetailViewModel
    @ObservedObject var initialNavigationViewModel: InitialNavigationViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
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

            HStack {
                Spacer()
                Button {
                    initialNavigationViewModel.showingReviewFish()
                } label: {
                    Text("Review fish count")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.glass)
                
                SearchBar(searchText: .constant(""))

                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
                .glassEffect()

            }

        }
        
    }
}
