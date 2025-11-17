//
//  ImageDetailHeaderView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/11/2025.
//

import SwiftUI


struct ImageDetailHeaderView: View {
    
    @ObservedObject var vm: ImageDetailViewModel
    
    var body: some View {
        
        HStack {
            
            Button {
                
                // TODO: navigate to back
                
            } label: {
                Image(systemName: "chevron.left")
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            
            Text(vm.species?.commonName ?? "")
                .textstyles(.largeTitleEmphasized)
            
            Text("(\(vm.species?.latinName ?? ""))")
                .textstyles(.bodyRegular)
            
            Spacer()
            
            Button {
                // TODO
                
            } label: {
                HStack {
                    Text("About this item")
                    Image(systemName: "info.circle")
                }
            }
            
            Button {
                
                // TODO
            } label: {
                Image(systemName: "arrow.down.circle")
            }
            
            
        }
        
        

    }
    
}

#Preview {
    ImageDetailHeaderView(vm: .preview)
        .frame(width: 1200, height: 800)
}
