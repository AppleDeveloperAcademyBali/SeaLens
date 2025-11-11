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
    
    // Fetch the footage by originalFileName
//    func getFootage(by uid: UUID) async -> Footage? {
//        let dataService = DataService(modelContainer: context.container)
//        let footageData = FootageData(dataService: dataService)
//        let predicate = #Predicate<Footage> { footage in
//            footage.uid == uid
//        }
//        
//        let sortDescriptors = [SortDescriptor(\Footage.dateCreated, order: .reverse)]
//        let result = await footageData.retrieveFootages(predicate: predicate, sortBy: sortDescriptors)
//        switch result {
//        case .success (let footages):
//            if footages.isEmpty {
//                return nil
//            }
//            return footages.first
//        case .failure(let error):
//            print("Error retrieving footage: \(error)")
//            return nil
//        }
        
//        if let error = footageData.errorMessage {
//            print("Error retrieving footage: \(error)")
//            return nil
//        }
//        
//        return footageData.footages.first
//    }
    
    
}
