//
//  DataService.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@ModelActor
final actor DataService {
    
    func save() async throws {
        try modelContext.save()
    }
    
    func retrieve<T: PersistentModel>(_ type: T.Type, predicate: Predicate<T>? = nil, sortBy: [SortDescriptor<T>] = []) async throws -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        return try modelContext.fetch(descriptor)
    }
    
    func insert<T: PersistentModel>(_ object: T) async {
        modelContext.insert(object)
    }
    
    func delete<T: PersistentModel>(_ object: T) async {
        modelContext.delete(object)
    }
    
    func deleteAll<T: PersistentModel>(for type: T.Type) async throws {
        try modelContext.delete(model: T.self)
    }

}
