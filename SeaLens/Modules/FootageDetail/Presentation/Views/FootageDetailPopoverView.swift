//
//  FootageDetailPopoverView.swift
//  SeaLens
//
//  Created by Handy Handy on 20/11/25.
//

import SwiftUI

struct FootageDetailPopoverView: View {
    @ObservedObject var footageDetailViewModel: FootageDetailViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text("FILE INFO")
                .textstyles(.caption1Regular)
                .foregroundStyle(.gray)
            HStack {
                Text("Name")
                    .textstyles(.bodyRegular)
                    .foregroundStyle(.gray)
                    .frame(width: 120, alignment: .leading)
                Text("\(footageDetailViewModel.footage?.filename ?? "")")
                    .textstyles(.bodyRegular)
                    .frame(alignment: .leading)
                Spacer()
            }
            HStack {
                Text("Original Time")
                    .textstyles(.bodyRegular)
                    .foregroundStyle(.gray)
                    .frame(width: 120, alignment: .leading)
                Text("\(footageDetailViewModel.footage?.originalFilename ?? "")")
                    .textstyles(.bodyRegular)
                    .frame(alignment: .leading)
                Spacer()
            }
            HStack {
                Text("Size")
                    .textstyles(.bodyRegular)
                    .foregroundStyle(.gray)
                    .frame(width: 120, alignment: .leading)
                Text("\((footageDetailViewModel.footage?.fileSize ?? 0.0).formatFileSize())")
                    .textstyles(.bodyRegular)
                    .frame(alignment: .leading)
                Spacer()
            }
            HStack {
                Text("Duration")
                    .textstyles(.bodyRegular)
                    .foregroundStyle(.gray)
                    .frame(width: 120, alignment: .leading)
                Text("\((Double(footageDetailViewModel.footage?.durationInSeconds ?? 0)).formatDuration())")
                    .textstyles(.bodyRegular)
                    .frame(alignment: .leading)
                Spacer()
            }
            HStack {
                Text("Date Taken")
                    .textstyles(.bodyRegular)
                    .foregroundStyle(.gray)
                    .frame(width: 120, alignment: .leading)
                Text("\((footageDetailViewModel.footage?.dateTaken ?? Date()).formatCreationDate())")
                    .textstyles(.bodyRegular)
                    .frame(alignment: .leading)
                Spacer()
            }
        }
        .padding()
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 16))
        .frame(width: 450)
    }
}
