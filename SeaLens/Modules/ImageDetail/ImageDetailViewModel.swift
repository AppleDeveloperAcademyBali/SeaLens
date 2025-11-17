//
//  ImageDetailViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/11/2025.
//

import Foundation
import SwiftUI
import SwiftData


@MainActor
final class ImageDetailViewModel: ObservableObject {
    
    @Injected private var domain: ImageDetailDomain


    
    // input
    @Published var fishImageUIDString: String = ""

    // output
    @Published var fish: Fish?
    @Published var species: FishSpeciesReference?
    @Published var images: [FishImage] = []
    @Published var selectedImage: FishImage?
    

    
    // MARK: - Load Image
    func loadImageDetail() {
        Task {
            guard let uid = UUID(uuidString: fishImageUIDString),
                  let image = await domain.getFishImage(by: uid) else {
                clear()
                return
            }
            
            selectedImage = image
            fish = image.fish
            images = image.fish.fishImages
            species = image.fish.fishSpeciesReference
        }
    }
    
    private func clear() {
        fish = nil
        species = nil
        images = []
        selectedImage = nil
    }
    

    
}


// MARK: - Extension for Preview
extension ImageDetailViewModel {
    static var preview: ImageDetailViewModel {
        let vm = ImageDetailViewModel()
        let mockFish = Fish.mock
        vm.images = mockFish.fishImages
        vm.selectedImage = mockFish.fishImages.first
        vm.fish = mockFish
        vm.species = mockFish.fishSpeciesReference
        vm.fishImageUIDString = vm.selectedImage?.uid.uuidString ?? ""
        return vm
    }
}
