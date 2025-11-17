//
//  ImageDetailPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/11/2025.
//


import SwiftUI
import SwiftData

struct ImageDetailPresentation: View {
    
    @StateObject var viewModel = ImageDetailViewModel()
    

   
    var body: some View {
        VStack {
            if viewModel.fishImageUIDString == "" {
                loadingView
            } else {
                VStack(alignment: .leading, spacing: 1) {
                    ImageDetailHeaderView(vm: viewModel)
                    
                    
                    Spacer()
                }
            }
        }
        .background(.blue)
    }
    
    
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...")
            Spacer()
        }
        .frame(width: 100, height: 100)
        .background(.red)
    }
    
}

