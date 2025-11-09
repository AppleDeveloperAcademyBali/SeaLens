//
//  TagComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct CustomTagsView: View {
    @ObservedObject var viewModel: UploadVideoViewModel
    @FocusState private var tagFocus: Bool
    @State private var isDisabled: Bool = false
    
    var body: some View {
        FlowHStack {
            ForEach(viewModel.tags, id: \.self) { tag in
                DeletableTextComponent(text: tag) {
                    viewModel.removeTag(tag)
                }
            }
            
            if viewModel.addTagPressed {
                ZStack (alignment: .trailing) {
                    TextField("", text: $viewModel.newTag, onEditingChanged: { changed in
                        isDisabled = changed
                        if changed {
                            print("Editing")
                        } else {
                            print("not editing")
                        }
                    }) {}
                        .focused($tagFocus)
                        .font(.body)
                        .frame(width: 120)
                        .onSubmit {
                            viewModel.addTag()
                        }
                    
                    Button {
                        viewModel.addTag()
                        tagFocus = false
                        viewModel.addTagPressed = false
                        isDisabled = false
                    } label: {
                        Image(systemName: "checkmark")
                            .resizable()
                            .padding(4)
                            .frame(width: 20, height: 20)
                        
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 4)
                    
                }
                .padding(.top, 5)
                
            }
            
            Button {
                viewModel.addTagPressed = true
                isDisabled = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add a tag")
                        .frame(height: 25)
                }
            }
            .buttonStyle(.glass)
            .disabled(isDisabled)
            
        }
    }
}

