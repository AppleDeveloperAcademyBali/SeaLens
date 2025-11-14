//
//  SeaLensSamples.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 29/10/25.
//

import Foundation

//FishFamilyReference
extension FishFamilyReference {
    static var sampleData: [FishFamilyReference] = [
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
            commonName: "Wrasse",
            imageUrl: "samplePicture",
            sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
            attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"
        ),
        FishFamilyReference(
            latinName: "Serranidae",
            commonName: "Grouper",
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
        )
    ]
}


//FishSpeciesReference
extension FishSpeciesReference {
    static var sampleData: [FishSpeciesReference] = {
        let familyRefs = FishFamilyReference.sampleData
        
        return [
            // Acanthuridae species
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Acanthurus leucosternon",
                commonName: "Powder Blue Tang",
                maxSizeInCm: 23.0,
                identification: "Blue body with yellow dorsal fin and white chin",
                location: "Indo-Pacific",
                imageUrl: "samplePicture",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[0]
            ),
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Zebrasoma flavescens",
                commonName: "Yellow Tang",
                maxSizeInCm: 20.0,
                identification: "Bright yellow body, oval shape",
                location: "Hawaii, Pacific Ocean",
                imageUrl: "https://example.com/yellow-tang.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[0]
            ),
            // Pomacentridae species
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Amphiprion ocellaris",
                commonName: "Clownfish",
                maxSizeInCm: 11.0,
                identification: "Orange with white bands outlined in black",
                location: "Indo-Pacific, Great Barrier Reef",
                imageUrl: "https://example.com/clownfish.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[1]
            ),
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Chromis viridis",
                commonName: "Blue Green Chromis",
                maxSizeInCm: 8.0,
                identification: "Blue-green body, forked tail",
                location: "Indo-Pacific",
                imageUrl: "https://example.com/chromis.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[1]
            ),
            // Labridae species
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Thalassoma lunare",
                commonName: "Moon Wrasse",
                maxSizeInCm: 25.0,
                identification: "Green body with pink and blue markings",
                location: "Indo-Pacific",
                imageUrl: "https://example.com/moon-wrasse.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[2]
            ),
            // Serranidae species
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Cephalopholis miniata",
                commonName: "Coral Grouper",
                maxSizeInCm: 45.0,
                identification: "Red body covered with blue spots",
                location: "Indo-Pacific",
                imageUrl: "https://example.com/coral-grouper.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[3]
            ),
            // Chaetodontidae species
            FishSpeciesReference(
                uid: UUID(),
                latinName: "Chaetodon lunulatus",
                commonName: "Pacific Butterflyfish",
                maxSizeInCm: 16.0,
                identification: "Yellow with vertical stripes and eye spot",
                location: "Pacific Ocean",
                imageUrl: "https://example.com/butterflyfish.jpg",
                sourceUrl: "https://www.fishbase.org.au/v4/summary/8014",
                attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)",
                fishFamilyReference: familyRefs[4]
            )
        ]
    }()
}

//Footage, FishFamily, Fish, FishConfidenceScore, FootageTags
extension Footage {
    static var sampleData: [Footage] = {
        let baseDate = Date()
        let familyRefs = FishFamilyReference.sampleData
        let speciesRefs = FishSpeciesReference.sampleData
        
        // Footage 1
        let footage1 = Footage(
            uid: UUID(),
            filename: "reef_survey_001.mp4",
            originalFilename: "GoPro_2024_001.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_001.mp4",
            durationInSeconds: 180,
            dateTaken: Calendar.current.date(byAdding: .day, value: -10, to: baseDate)!,
            location: "Great Barrier Reef, Australia",
            siteName: "Agincourt Reef",
            transect: "T1",
            depthInMeter: 12.5,
            dateCreated: baseDate
        )
        footage1.footageTags = [
            FootageTags(uid: UUID(), name: "coral", footage: footage1),
            FootageTags(uid: UUID(), name: "clear-water", footage: footage1)
        ]
        
        let fishFamily1 = FishFamily(
            numOfFishDetected: 8,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage1,
            fishFamilyReference: familyRefs[0]
        )
        
        // After creating fish1, create more fish for the same family
        let fish1 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_001.jpg",
            objectRecognitionConf: 0.92,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily1,
            fishSpeciesReference: speciesRefs[0]
        )
        fish1.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Acanthuridae", confidenceValue: 0.92, fish: fish1),
            FishConfidenceScore(familyLatinName: "Labridae", confidenceValue: 0.05, fish: fish1)
        ]

        // Add more fish to the same family
        let fish1b = Fish(
            imageUrl: "samplePicture",
            objectRecognitionConf: 0.89,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily1,
            fishSpeciesReference: speciesRefs[0]
        )

        let fish1c = Fish(
            imageUrl: "samplePicture",
            objectRecognitionConf: 0.91,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily1,
            fishSpeciesReference: speciesRefs[1]
        )

        let fish1d = Fish(
            imageUrl: "samplePicture",
            objectRecognitionConf: 0.88,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily1,
            fishSpeciesReference: speciesRefs[0]
        )

        let fish1e = Fish(
            imageUrl: "samplePicture",
            objectRecognitionConf: 0.90,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily1,
            fishSpeciesReference: speciesRefs[1]
        )

        // Update the fish array
        fishFamily1.fish = [fish1, fish1b, fish1c, fish1d, fish1e]
        footage1.fishFamily = [fishFamily1]
        
        // Footage 2
        let footage2 = Footage(
            uid: UUID(),
            filename: "reef_survey_002.mp4",
            originalFilename: "GoPro_2024_002.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_002.mp4",
            durationInSeconds: 240,
            dateTaken: Calendar.current.date(byAdding: .day, value: -9, to: baseDate)!,
            location: "Maldives",
            siteName: "Banana Reef",
            transect: "T2",
            depthInMeter: 15.0,
            dateCreated: baseDate
        )
        footage2.footageTags = [
            FootageTags(uid: UUID(), name: "reef", footage: footage2),
            FootageTags(uid: UUID(), name: "tropical", footage: footage2)
        ]
        
        let fishFamily2 = FishFamily(
            numOfFishDetected: 15,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage2,
            fishFamilyReference: familyRefs[1]
        )
        
        let fish2 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_002.jpg",
            objectRecognitionConf: 0.88,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily2,
            fishSpeciesReference: speciesRefs[2]
        )
        fish2.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Pomacentridae", confidenceValue: 0.88, fish: fish2)
        ]
        
        fishFamily2.fish = [fish2]
        footage2.fishFamily = [fishFamily2]
        
        // Footage 3
        let footage3 = Footage(
            uid: UUID(),
            filename: "reef_survey_003.mp4",
            originalFilename: "GoPro_2024_003.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_003.mp4",
            durationInSeconds: 300,
            dateTaken: Calendar.current.date(byAdding: .day, value: -8, to: baseDate)!,
            location: "Raja Ampat, Indonesia",
            siteName: "Cape Kri",
            transect: "T1",
            depthInMeter: 18.0,
            dateCreated: baseDate
        )
        footage3.footageTags = [
            FootageTags(uid: UUID(), name: "biodiversity-hotspot", footage: footage3)
        ]
        
        let fishFamily3 = FishFamily(
            numOfFishDetected: 25,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage3,
            fishFamilyReference: familyRefs[2]
        )
        
        let fish3 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_003.jpg",
            objectRecognitionConf: 0.95,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily3,
            fishSpeciesReference: speciesRefs[4]
        )
        fish3.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Labridae", confidenceValue: 0.95, fish: fish3)
        ]
        
        fishFamily3.fish = [fish3]
        footage3.fishFamily = [fishFamily3]
        
        // Footage 4
        let footage4 = Footage(
            uid: UUID(),
            filename: "reef_survey_004.mp4",
            originalFilename: "GoPro_2024_004.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_004.mp4",
            durationInSeconds: 210,
            dateTaken: Calendar.current.date(byAdding: .day, value: -7, to: baseDate)!,
            location: "Red Sea, Egypt",
            siteName: "Ras Mohammed",
            transect: "T3",
            depthInMeter: 20.0,
            dateCreated: baseDate
        )
        footage4.footageTags = [
            FootageTags(uid: UUID(), name: "wall-dive", footage: footage4),
            FootageTags(uid: UUID(), name: "current", footage: footage4)
        ]
        
        let fishFamily4 = FishFamily(
            numOfFishDetected: 12,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage4,
            fishFamilyReference: familyRefs[3]
        )
        
        let fish4 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_004.jpg",
            objectRecognitionConf: 0.87,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily4,
            fishSpeciesReference: speciesRefs[5]
        )
        fish4.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Serranidae", confidenceValue: 0.87, fish: fish4),
            FishConfidenceScore(familyLatinName: "Labridae", confidenceValue: 0.08, fish: fish4)
        ]
        
        fishFamily4.fish = [fish4]
        footage4.fishFamily = [fishFamily4]
        
        // Footage 5
        let footage5 = Footage(
            uid: UUID(),
            filename: "reef_survey_005.mp4",
            originalFilename: "GoPro_2024_005.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_005.mp4",
            durationInSeconds: 270,
            dateTaken: Calendar.current.date(byAdding: .day, value: -6, to: baseDate)!,
            location: "Palau",
            siteName: "Blue Corner",
            transect: "T2",
            depthInMeter: 22.0,
            dateCreated: baseDate
        )
        footage5.footageTags = [
            FootageTags(uid: UUID(), name: "shark-present", footage: footage5),
            FootageTags(uid: UUID(), name: "strong-current", footage: footage5)
        ]
        
        let fishFamily5 = FishFamily(
            numOfFishDetected: 30,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage5,
            fishFamilyReference: familyRefs[1]
        )
        
        let fish5 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_005.jpg",
            objectRecognitionConf: 0.91,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily5,
            fishSpeciesReference: speciesRefs[3]
        )
        fish5.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Pomacentridae", confidenceValue: 0.91, fish: fish5)
        ]
        
        fishFamily5.fish = [fish5]
        footage5.fishFamily = [fishFamily5]
        
        // Footage 6
        let footage6 = Footage(
            uid: UUID(),
            filename: "reef_survey_006.mp4",
            originalFilename: "GoPro_2024_006.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_006.mp4",
            durationInSeconds: 195,
            dateTaken: Calendar.current.date(byAdding: .day, value: -5, to: baseDate)!,
            location: "Komodo, Indonesia",
            siteName: "Batu Bolong",
            transect: "T1",
            depthInMeter: 16.5,
            dateCreated: baseDate
        )
        footage6.footageTags = [
            FootageTags(uid: UUID(), name: "pinnacle", footage: footage6)
        ]
        
        let fishFamily6 = FishFamily(
            numOfFishDetected: 18,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage6,
            fishFamilyReference: familyRefs[4]
        )
        
        let fish6 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_006.jpg",
            objectRecognitionConf: 0.89,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily6,
            fishSpeciesReference: speciesRefs[6]
        )
        fish6.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Chaetodontidae", confidenceValue: 0.89, fish: fish6),
            FishConfidenceScore(familyLatinName: "Pomacentridae", confidenceValue: 0.07, fish: fish6)
        ]
        
        fishFamily6.fish = [fish6]
        footage6.fishFamily = [fishFamily6]
        
        // Footage 7
        let footage7 = Footage(
            uid: UUID(),
            filename: "reef_survey_007.mp4",
            originalFilename: "GoPro_2024_007.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_007.mp4",
            durationInSeconds: 225,
            dateTaken: Calendar.current.date(byAdding: .day, value: -4, to: baseDate)!,
            location: "Fiji",
            siteName: "Rainbow Reef",
            transect: "T4",
            depthInMeter: 14.0,
            dateCreated: baseDate
        )
        footage7.footageTags = [
            FootageTags(uid: UUID(), name: "soft-coral", footage: footage7),
            FootageTags(uid: UUID(), name: "colorful", footage: footage7)
        ]
        
        let fishFamily7 = FishFamily(
            numOfFishDetected: 22,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage7,
            fishFamilyReference: familyRefs[0]
        )
        
        let fish7 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_007.jpg",
            objectRecognitionConf: 0.93,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily7,
            fishSpeciesReference: speciesRefs[1]
        )
        fish7.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Acanthuridae", confidenceValue: 0.93, fish: fish7)
        ]
        
        fishFamily7.fish = [fish7]
        footage7.fishFamily = [fishFamily7]
        
        // Footage 8
        let footage8 = Footage(
            uid: UUID(),
            filename: "reef_survey_008.mp4",
            originalFilename: "GoPro_2024_008.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_008.mp4",
            durationInSeconds: 260,
            dateTaken: Calendar.current.date(byAdding: .day, value: -3, to: baseDate)!,
            location: "Belize",
            siteName: "Blue Hole",
            transect: "T1",
            depthInMeter: 25.0,
            dateCreated: baseDate
        )
        footage8.footageTags = [
            FootageTags(uid: UUID(), name: "deep-dive", footage: footage8),
            FootageTags(uid: UUID(), name: "cavern", footage: footage8)
        ]
        
        let fishFamily8 = FishFamily(
            numOfFishDetected: 10,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage8,
            fishFamilyReference: familyRefs[3]
        )
        
        let fish8 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_008.jpg",
            objectRecognitionConf: 0.85,
            isFavorites: false,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily8,
            fishSpeciesReference: speciesRefs[5]
        )
        fish8.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Serranidae", confidenceValue: 0.85, fish: fish8)
        ]
        
        fishFamily8.fish = [fish8]
        footage8.fishFamily = [fishFamily8]
        
        // Footage 9
        let footage9 = Footage(
            uid: UUID(),
            filename: "reef_survey_009.mp4",
            originalFilename: "GoPro_2024_009.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_009.mp4",
            durationInSeconds: 205,
            dateTaken: Calendar.current.date(byAdding: .day, value: -2, to: baseDate)!,
            location: "Philippines",
            siteName: "Apo Island",
            transect: "T2",
            depthInMeter: 11.0,
            dateCreated: baseDate
        )
        footage9.footageTags = [
            FootageTags(uid: UUID(), name: "turtle-present", footage: footage9),
            FootageTags(uid: UUID(), name: "sanctuary", footage: footage9)
        ]
        
        let fishFamily9 = FishFamily(
            numOfFishDetected: 35,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage9,
            fishFamilyReference: familyRefs[2]
        )
        
        let fish9 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_009.jpg",
            objectRecognitionConf: 0.94,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily9,
            fishSpeciesReference: speciesRefs[4]
        )
        fish9.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Labridae", confidenceValue: 0.94, fish: fish9),
            FishConfidenceScore(familyLatinName: "Acanthuridae", confidenceValue: 0.04, fish: fish9)
        ]
        
        fishFamily9.fish = [fish9]
        footage9.fishFamily = [fishFamily9]
        
        // Footage 10
        let footage10 = Footage(
            uid: UUID(),
            filename: "reef_survey_010.mp4",
            originalFilename: "GoPro_2024_010.mp4",
            footageUrl: "https://storage.example.com/videos/reef_survey_010.mp4",
            durationInSeconds: 285,
            dateTaken: Calendar.current.date(byAdding: .day, value: -1, to: baseDate)!,
            location: "Thailand",
            siteName: "Richelieu Rock",
            transect: "T3",
            depthInMeter: 19.0,
            dateCreated: baseDate
        )
        footage10.footageTags = [
            FootageTags(uid: UUID(), name: "whale-shark-site", footage: footage10),
            FootageTags(uid: UUID(), name: "macro", footage: footage10)
        ]
        
        let fishFamily10 = FishFamily(
            numOfFishDetected: 28,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            footage: footage10,
            fishFamilyReference: familyRefs[1]
        )
        
        let fish10 = Fish(
            imageUrl: "https://storage.example.com/fish/fish_010.jpg",
            objectRecognitionConf: 0.90,
            isFavorites: true,
            dateCreated: baseDate,
            dateUpdated: baseDate,
            fishFamily: fishFamily10,
            fishSpeciesReference: speciesRefs[2]
        )
        fish10.fishConfidenceScores = [
            FishConfidenceScore(familyLatinName: "Pomacentridae", confidenceValue: 0.90, fish: fish10)
        ]
        
        fishFamily10.fish = [fish10]
        footage10.fishFamily = [fishFamily10, fishFamily1, fishFamily2, fishFamily3, fishFamily4, fishFamily9, fishFamily5, fishFamily8, fishFamily7, fishFamily6]
        
        return [
            footage1, footage2, footage3, footage4, footage5,
            footage6, footage7, footage8, footage9, footage10
        ]
    }()
}
