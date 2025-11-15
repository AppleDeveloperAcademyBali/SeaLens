//
//  DummyDataService.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 28/10/25.
//

//
//  DummyDataService.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 28/10/25.
//

import SwiftData
import Foundation

final class DummyDataService {
    
    // MARK: - Fish Family References (Master Data)
    static func createFishFamilyReferences() -> [FishFamilyReference] {
        return [
            FishFamilyReference(
                latinName: "Acanthuridae",
                commonName: "Surgeonfish",
                imageUrl: "samplePicture",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"
            ),
            FishFamilyReference(
                latinName: "Pomacentridae",
                commonName: "Damselfish",
                imageUrl: "samplePicture",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"
            ),
            FishFamilyReference(
                latinName: "Labridae",
                commonName: "Wrasses",
                imageUrl: "samplePicture",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"
            ),
            FishFamilyReference(
                latinName: "Chaetodontidae",
                commonName: "Butterflyfish",
                imageUrl: "samplePicture",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"
            ),
            FishFamilyReference(
                latinName: "Serranidae",
                commonName: "Groupers",
                imageUrl: "samplePicture",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"
            )
        ]
    }
    
    // MARK: - Fish Species References (Master Data)
    static func createFishSpeciesReferences(familyReferences: [FishFamilyReference]) -> [FishSpeciesReference] {
        var species: [FishSpeciesReference] = []
        
        // Acanthuridae species
        if let surgeonfish = familyReferences.first(where: { $0.latinName == "Acanthuridae" }) {
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Acanthurus triostegus",
                commonName: "Convict Surgeonfish",
                maxSizeInCm: 27.0,
                identification: "White body with 5-6 vertical black bars",
                location: "Indo-Pacific reefs",
                imageUrl: "https://example.com/convict-surgeonfish.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: surgeonfish
            ))
            
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Zebrasoma flavescens",
                commonName: "Yellow Tang",
                maxSizeInCm: 20.0,
                identification: "Bright yellow body, white tail spine",
                location: "Hawaiian Islands, Western Pacific",
                imageUrl: "https://example.com/yellow-tang.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: surgeonfish
            ))
        }
        
        // Pomacentridae species
        if let damselfish = familyReferences.first(where: { $0.latinName == "Pomacentridae" }) {
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Chromis viridis",
                commonName: "Green Chromis",
                maxSizeInCm: 9.0,
                identification: "Bright blue-green body, forked tail",
                location: "Indo-Pacific coral reefs",
                imageUrl: "https://example.com/green-chromis.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: damselfish
            ))
            
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Amphiprion ocellaris",
                commonName: "Clownfish",
                maxSizeInCm: 11.0,
                identification: "Orange with three white bars outlined in black",
                location: "Eastern Indian Ocean, Western Pacific",
                imageUrl: "https://example.com/clownfish.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: damselfish
            ))
        }
        
        // Labridae species
        if let wrasses = familyReferences.first(where: { $0.latinName == "Labridae" }) {
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Thalassoma lunare",
                commonName: "Moon Wrasse",
                maxSizeInCm: 25.0,
                identification: "Green body with pink-red markings, yellow tail",
                location: "Indo-Pacific reefs",
                imageUrl: "https://example.com/moon-wrasse.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: wrasses
            ))
        }
        
        // Chaetodontidae species
        if let butterflyfish = familyReferences.first(where: { $0.latinName == "Chaetodontidae" }) {
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Chaetodon auriga",
                commonName: "Threadfin Butterflyfish",
                maxSizeInCm: 23.0,
                identification: "White body with chevron pattern, black eyespot",
                location: "Indo-Pacific coral reefs",
                imageUrl: "https://example.com/threadfin-butterfly.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: butterflyfish
            ))
        }
        
        // Serranidae species
        if let groupers = familyReferences.first(where: { $0.latinName == "Serranidae" }) {
            species.append(FishSpeciesReference(
                uid: UUID(),
                latinName: "Cephalopholis miniata",
                commonName: "Coral Grouper",
                maxSizeInCm: 45.0,
                identification: "Red-orange body covered with blue spots",
                location: "Indo-Pacific reefs",
                imageUrl: "https://example.com/coral-grouper.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: groupers
            ))
        }
        
        return species
    }
    
    // MARK: - Generate Complete Dataset
    static func generateDummyData(context: ModelContext) {
        // Create master reference data
        let familyReferences = createFishFamilyReferences()
        familyReferences.forEach { context.insert($0) }
        
        let speciesReferences = createFishSpeciesReferences(familyReferences: familyReferences)
        speciesReferences.forEach { context.insert($0) }
        
        // Create 10 footages with associated data
        let locations = [
            "Great Barrier Reef, Australia",
            "Raja Ampat, Indonesia",
            "Tubbataha Reef, Philippines",
            "Red Sea, Egypt",
            "Maldives",
            "Palau",
            "Komodo National Park, Indonesia",
            "Sipadan Island, Malaysia",
            "Galapagos Islands, Ecuador",
            "Coral Triangle, Southeast Asia"
        ]
        
        let siteNames = [
            "Blue Corner",
            "Crystal Bay",
            "The Canyon",
            "Shark Point",
            "Manta Ridge",
            "Garden Eel Cove",
            "Barracuda Point",
            "Turtle Tomb",
            "Coral Garden",
            "Drop Off"
        ]
        
        let baseDate = Date()
        var individualFishCounter = 1
        
        for i in 0..<30 {
            let footage = Footage(
                uid: UUID(),
                filename: "footage_\(String(format: "%03d", i + 1)).mp4",
                originalFilename: "GOPR\(1000 + i).MP4",
                footageUrl: "https://storage.example.com/footage_\(i + 1).mp4",
                durationInSeconds: Int32.random(in: 120...600),
                dateTaken: Calendar.current.date(byAdding: .day, value: -i * 3, to: baseDate)!,
                location: locations[abs(i/3)],
                siteName: siteNames[abs(i/3)],
                transect: "T\(abs(i/3) + 1)",
                depthInMeter: Double.random(in: 5...30),
                dateCreated: baseDate,
                dateUpdated: baseDate,
                footageTags: []
            )
            context.insert(footage)
            
            // Add 2-3 tags per footage
            let tagNames = ["Coral Health Survey", "Fish Count", "Biodiversity Assessment", "Seasonal Study", "Conservation Monitoring"]
            let numTags = Int.random(in: 2...3)
            for j in 0..<numTags {
                let tag = FootageTags(
                    uid: UUID(),
                    name: tagNames.shuffled()[j],
                    footage: footage
                )
                context.insert(tag)
            }
            
            // Create 2-4 fish families per footage
            let numFamilies = Int.random(in: 2...4)
            for _ in 0..<numFamilies {
                guard let randomFamilyRef = familyReferences.randomElement() else { continue }
                
                let fishFamily = FishFamily(
                    uid: UUID(),
                    numOfFishDetected: Int32.random(in: 5...25),
                    dateCreated: baseDate,
                    dateUpdated: baseDate,
                    footage: footage,
                    fishFamilyReference: randomFamilyRef
                )
                context.insert(fishFamily)
                
                // Create 2-5 individual fish per family
                let numIndividualFish = Int.random(in: 2...5)
                for _ in 0..<numIndividualFish {
                    // Get a random species from this family
                    let speciesForFamily = speciesReferences.filter {
                        $0.fishFamilyReference?.latinName == randomFamilyRef.latinName
                    }
                    guard let randomSpecies = speciesForFamily.randomElement() else { continue }
                    
                    // Create IndividualFish with temporary empty fish array
                    let individualFish = IndividualFish(
                        uid: UUID(),
                        fishId: "FISH-\(String(format: "%04d", individualFishCounter))",
                        dateCreated: baseDate,
                        dateUpdated: baseDate,
                        fishFamily: fishFamily,
                        fishSpeciesReference: randomSpecies,
                        fish: []
                    )
                    context.insert(individualFish)
                    individualFishCounter += 1
                    
                    // Create 2-5 fish detections for this individual fish
                    let numFishDetections = Int.random(in: 2...5)
                    for _ in 0..<numFishDetections {
                        let fish = Fish(
                            uid: UUID(),
                            imageUrl: "https://storage.example.com/fish_\(UUID().uuidString).jpg",
                            objectRecognitionConf: Double.random(in: 0.75...0.99),
                            timestamp: String(format: "00:%02d:%02d:00",
                                            Int.random(in: 0...5),
                                            Int.random(in: 0...59)),
                            isFavorites: Bool.random(),
                            dateCreated: baseDate,
                            dateUpdated: baseDate,
                            individualFish: individualFish
                        )
                        context.insert(fish)
                        
                        // Add 2-5 confidence scores per fish
                        let numScores = Int.random(in: 2...5)
                        let selectedFamilies = familyReferences.shuffled().prefix(numScores)
                        
                        for (index, family) in selectedFamilies.enumerated() {
                            let confidence = index == 0
                                ? Double.random(in: 0.70...0.95)  // Highest for first (most likely family)
                                : Double.random(in: 0.10...0.60)  // Lower for others
                            
                            let score = FishConfidenceScore(
                                uid: UUID(),
                                familyLatinName: family.latinName,
                                confidenceValue: confidence,
                                fish: fish
                            )
                            context.insert(score)
                        }
                    }
                }
            }
        }
        
        // Save all changes
        do {
            try context.save()
            print("✅ Dummy data generated successfully!")
            print("📊 Generated \(individualFishCounter - 1) individual fish across 10 footage items")
        } catch {
            print("❌ Error saving dummy data: \(error)")
        }
    }
    
    // MARK: - Clean Up
    static func deleteAllData(context: ModelContext) {
        do {
            try context.delete(model: Footage.self)
            try context.delete(model: FishFamily.self)
            try context.delete(model: IndividualFish.self)
            try context.delete(model: Fish.self)
            try context.delete(model: FishConfidenceScore.self)
            try context.delete(model: FootageTags.self)
            try context.delete(model: FishFamilyReference.self)
            try context.delete(model: FishSpeciesReference.self)
            try context.delete(model: Location.self)
            try context.delete(model: Site.self)
            try context.delete(model: Transect.self)
            
            try context.save()
            print("✅ All data deleted successfully!")
        } catch {
            print("❌ Error deleting data: \(error)")
        }
    }
}

// MARK: - Usage Example
/*
 Usage in your app:
 
 // In your App struct or initial view:
 @Environment(\.modelContext) private var modelContext
 
 .onAppear {
     // Generate dummy data on first launch
     DummyDataService.generateDummyData(context: modelContext)
 }
 
 // Or add a button in debug builds:
 #if DEBUG
 Button("Generate Dummy Data") {
     DummyDataService.generateDummyData(context: modelContext)
 }
 
 Button("Delete All Data") {
     DummyDataService.deleteAllData(context: modelContext)
 }
 #endif
 */


extension DummyDataService {
    static func generateSampleFishFamilies(for footage: Footage, context: ModelContext) {
        //  Get or create the family reference data first
        let familyReferences = createFishFamilyReferences()
        familyReferences.forEach { context.insert($0) }

        // For this one footage, create a few random fish families
        let baseDate = Date()
        let numFamilies = Int.random(in: 2...4)

        for _ in 0..<numFamilies {
            guard let randomFamilyRef = familyReferences.randomElement() else { continue }

            // Create a FishFamily linked to this footage
            let fishFamily = FishFamily(
                uid: UUID(),
                numOfFishDetected: Int32.random(in: 5...20),
                dateCreated: baseDate,
                dateUpdated: baseDate,
                footage: footage,
                fishFamilyReference: randomFamilyRef
            )
            context.insert(fishFamily)

//            // Add some random Fish for the family
//            let numFish = Int.random(in: 2...5)
//            for _ in 0..<numFish {
//                let fish = Fish(
//                    uid: UUID(),
//                    imageUrl: "samplePicture",
//                    objectRecognitionConf: Double.random(in: 0.7...0.99),
//                    timestamp: "00:01:15:40",
//                    isFavorites: Bool.random(),
//                    dateCreated: baseDate,
//                    dateUpdated: baseDate,
//                    individualFish: IndividualFish(
//                        fishId: UUID(),
//                        dateCreated: baseDate,
//                        dateUpdated: baseDate,
//                        fishFamily: fishFamily,
//                        fishSpeciesReference: ,
//                        fish: []
//                    )
//                )
//                context.insert(fish)
//            }
        }

        do {
            try context.save()
            print("Added sample FishFamilies for footage: \(footage.filename)")
        } catch {
            print("Failed to save sample FishFamilies: \(error)")
        }
    }
}
