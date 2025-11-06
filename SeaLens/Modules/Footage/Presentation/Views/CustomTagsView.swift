//
//  TagComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct CustomTagsView: View {
    @ObservedObject var viewModel: UploadVideoViewModel
    
    var body: some View {
        FlowHStack {
            ForEach(viewModel.tags, id: \.self) { tag in
                DeletableTextComponent(text: tag) {
                    viewModel.removeTag(tag)
                }
            }
                 
            if viewModel.addTagPressed {
                TextField(text: $viewModel.newTag) {}
                    .font(.body)
                    .frame(width: 120)
                    .padding(.top, 5)
                    .onSubmit {
                        viewModel.addTag()
                        viewModel.newTag = ""
                    }
            }
                        
            Button {
                viewModel.addTagPressed = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add a tag")
                        .frame(height: 25)
                }
            }
            .buttonStyle(.glass)

        }
    }
}

#Preview {
    CustomTagsView(viewModel: UploadVideoViewModel())
}
