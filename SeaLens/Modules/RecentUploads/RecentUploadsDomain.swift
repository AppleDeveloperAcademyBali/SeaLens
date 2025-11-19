//
//  RecentUploadDomain.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import Foundation
import SwiftData

class RecentUploadsDomain {
    @Injected private var footageData: FootageData
    
    func retrieveFootages() async -> [Footage] {
        //TODO: - Implement sorting based on the uploaded footage to server
        let result = await footageData.retrieveFootages()
        
        switch result {
        case .success(let footages): return footages
        case .failure(let error):
            print("Error retrieving footage: \(error)")
            return []
        }
    }
    
    
    func retrieveFootage(uuidList: Set<UUID>) async -> [Footage] {
        var result: Result<[Footage], Error>
        
        if uuidList.isEmpty {
            result = await footageData.retrieveFootages()
        } else {
            let sortBy = [SortDescriptor(\Footage.dateTaken, order: .reverse)]
            let predicate = #Predicate<Footage> { uuidList.contains($0.uid) }
            result = await footageData.retrieveFootages(predicate: predicate, sortBy: sortBy)
        }
        
        switch result {
        case .success(let footages): return footages
        case .failure(let error):
            print("Error retrieving footage: \(error)")
            return []
        }
    }
}
