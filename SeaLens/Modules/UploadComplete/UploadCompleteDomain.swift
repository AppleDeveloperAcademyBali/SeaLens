//
//  UploadCompleteDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 10/11/2025.
//

import Foundation
import SwiftData


final class UploadCompleteDomain {
    private let footageData: FootageData
    
    init(footageData: FootageData) {
        self.footageData = footageData
    }
    
    
    func getFootage(by uid: UUID) async -> Footage? {
        let predicate = #Predicate<Footage> { $0.uid == uid }
        let sortDescriptors = [SortDescriptor(\Footage.dateCreated, order: .reverse)]
        
        let result = await footageData.retrieveFootages(predicate: predicate, sortBy: sortDescriptors)
        switch result {
        case .success(let footages): return footages.first
        case .failure(let error):
            print("Error retrieving footage: \(error)")
            return nil
        }
    }

    
    
}
