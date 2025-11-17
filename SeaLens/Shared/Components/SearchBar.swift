//
//  SearchBar.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search a file", text: $searchText)
                .textstyles(.bodyRegular)
                .textFieldStyle(PlainTextFieldStyle())
            
            Spacer()
            
            Image(systemName: "magnifyingglass")
                .frame(width: 25, height: 40)
        }
        .padding()
        .frame(width: 300, height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1)
        )
        .cornerRadius(16)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
