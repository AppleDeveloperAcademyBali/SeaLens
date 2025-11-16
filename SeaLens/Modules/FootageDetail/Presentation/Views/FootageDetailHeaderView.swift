//
//  FootageDetailHeaderView.swift
//  SeaLens
//
//  Created by Handy Handy on 16/11/25.
//
import SwiftUI

struct FootageDetailHeaderView: View {
    @ObservedObject var FootageDetailViewModel: FootageDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Upload Complete")
                    .textstyles(.title1Emphasized)

                if let name = FootageDetailViewModel.footage?.filename  {
                    VideoTag(fileName: name)
                }
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
