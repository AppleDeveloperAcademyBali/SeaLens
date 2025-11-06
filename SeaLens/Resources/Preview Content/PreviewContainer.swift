//
//  PreviewContainer.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 29/10/25.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: Footage.self, configurations: config)
        } catch {
            fatalError("Could not create a new container")
        }
    }
    
    func addExamples(_ examples: [Footage]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
