//
//  DataService.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class DataService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save() throws {
        try modelContext.save()
    }
    
    func retrieve<T: PersistentModel>(_ type: T.Type, predicate: Predicate<T>? = nil, sortBy: [SortDescriptor<T>] = []) throws -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        return try modelContext.fetch(descriptor)
    }
    
    func insert<T: PersistentModel>(_ object: T) {
        modelContext.insert(object)
    }
    
    func delete<T: PersistentModel>(_ object: T) {
        modelContext.delete(object)
    }
    
    func deleteAll<T: PersistentModel>(for type: T.Type) throws {
        try modelContext.delete(model: T.self)
    }

}
