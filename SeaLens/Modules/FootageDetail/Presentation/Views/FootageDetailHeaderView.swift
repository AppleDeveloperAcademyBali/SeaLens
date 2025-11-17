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
        VStack (alignment: .leading) {
            HStack {
                Text(footageDetailViewModel.getTitle())
                    .textstyles(.title1Emphasized)
                
                Button {
                    print("Pop Up Info")
                } label: {
                    Image(systemName: "info.circle")
                        .textstyles(.title3Medium)
                        .foregroundStyle(.blue)
                        .padding(4)
                        
                }
                .glassEffect()
                .clipShape(Circle())

            }

            HStack {
                Spacer()
                Button { } label: {
                    Text("Review fish count")
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.glass)

                Button { } label: {
                    Image("iconSort")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)

                Button { } label: {
                    Image("iconFilter")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
            }

        }
    }
}
