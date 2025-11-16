//
//  UploadCompleteViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 10/11/2025.
//

import Foundation
import SwiftUI
import SwiftData


@MainActor
final class FootageDetailViewModel: ObservableObject {
    
    @Published var footage: Footage?
    @Published var fishFamilies: [FishFamily] = []
    
    private let domain: FootageDetailDomain
    private let footageUID: UUID
    
    // pass in the swiftdata context from the view
    init(footageUID: UUID, domain: FootageDetailDomain) {
        self.footageUID = footageUID
        self.domain = domain
    }
    
    func loadFootage() {
        Task {
            if let fetchedFootage = await domain.getFootage(by: footageUID)   {
                self.footage = fetchedFootage
                self.fishFamilies = fetchedFootage.fishFamily
            } else {
                self.footage = nil
                self.fishFamilies = []
            }
        }
    }
}



extension FootageDetailViewModel {
    // convenience initializer for previews that doesn't require domain/data layer
    convenience init(footage: Footage) {
        // create a dummy domain - won't be used in preview
        let dataService = DataService(modelContainer: try! ModelContainer(for: Footage.self))
        let footageData = FootageData(dataService: dataService)
        let domain = FootageDetailDomain(footageData: footageData)
        
        self.init(footageUID: footage.uid, domain: domain)
        
        // directly set the data for preview
        self.footage = footage
        self.fishFamilies = footage.fishFamily
    }
}
