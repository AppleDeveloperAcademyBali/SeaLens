//
//  MockDataView.swift
//  SeaLens
//
//  Created by Handy Handy on 15/11/25.
//

import SwiftUI

struct MockDataView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        HStack {
            Button("Generate Dummy Data") {
                MockDataSeeder.seedIfEmpty(modelContext)
            }
            
            Button("Delete all data") {
                MockDataSeeder.deleteAllData(in: modelContext)
            }
        }
    }
}

#Preview {
    MockDataView()
}
