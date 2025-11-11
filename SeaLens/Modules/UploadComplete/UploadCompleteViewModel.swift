//
//  UploadCompleteViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 10/11/2025.
//

import Foundation
import SwiftUI


@MainActor
final class UploadCompleteViewModel: ObservableObject {
    
    @Published var footage: Footage?
    @Published var fishFamilies: [FishFamily] = []
    
    private let domain: UploadCompleteDomain
    private let footageUID: UUID
    
    // pass in the swiftdata context from the view
    init(footageUID: UUID, domain: UploadCompleteDomain) {
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
