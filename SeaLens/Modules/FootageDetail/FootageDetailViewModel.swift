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
    @Injected private var domain: FootageDetailDomain
    //
    @Published var footageUIDString: String = ""
    //
    @Published var footage: Footage?
    @Published var fishFamilies: [FishFamily] = []
    @Published var allFishFamilies: [FishFamily] = []
    @Published var searchText: String = ""
    //
    @Published var totalFish: Int = 0
    @Published var totalPhotos: Int = 0
    //
    @Published var popoverIsPresented: Bool = false
    
    init(footageUIDString: String) {
        self.footageUIDString = footageUIDString
    }
    
    func loadData() async {
        await loadFootage()
        await loadFishFamilies()
        await getTotalFish()
        await getTotalPhotos()
        applySearching()
    }
    
    func loadFootage() async {
        if let uid = UUID(uuidString: footageUIDString),
            let fetchedFootage = await domain.getFootage(by: uid)   {
            self.footage = fetchedFootage
            self.allFishFamilies = fetchedFootage.fishFamily
        } else {
            self.footage = .mock
            self.allFishFamilies = []
        }
    }
    
    func loadFishFamilies() async {
        guard let uid = UUID(uuidString: footageUIDString),
           let fetchedFishFamilies = await domain.getFootage(by: uid)?.fishFamily
        else { return }
        self.allFishFamilies = fetchedFishFamilies
    }
    
    func getTitle() -> String {
        guard
            let dateTaken = footage?.dateTaken,
            let location = footage?.locationName
        else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let formattedDate = formatter.string(from: dateTaken)
        return "\(location) - \(formattedDate)"
    }
    
    func getTotalFish() async {
        guard let uid = UUID(uuidString: footageUIDString) else { return }
        totalFish = await domain.getTotalFish(by: uid)
    }
    
    func getTotalPhotos() async {
        guard let uid = UUID(uuidString: footageUIDString) else { return }
        totalPhotos = await domain.getTotalPhotos(by: uid)
    }
    
    // Apply Sorting for the Presentation
    func applySorting(sortOption: SortOption)
    {
        switch sortOption {
        case .dateTakenNewest:
            fishFamilies.sort { $0.dateCreated > $1.dateCreated }
            break
        case .dateTakenOldest:
            fishFamilies.sort { $0.dateCreated < $1.dateCreated }
            break
        case .filenameAscending:
            fishFamilies.sort { $0.fishFamilyReference?.commonName ?? "" < $1.fishFamilyReference?.commonName ?? "" }
            break
        case .filenameDesscending:
            fishFamilies.sort { $0.fishFamilyReference?.commonName ?? "" > $1.fishFamilyReference?.commonName ?? "" }
            break
        }
    }
    
    // Apply Searching for the Presentation
    func applySearching()
    {
        if searchText.isEmpty {
            fishFamilies = allFishFamilies
        } else {
            fishFamilies = allFishFamilies.filter { $0.fishFamilyReference?.commonName.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
}
