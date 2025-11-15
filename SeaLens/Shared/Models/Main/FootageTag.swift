//
//  Tags.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FootageTag {
    @Attribute(.unique) var uid: UUID
    var name: String
    
    //0..many footageTags belong to one footage
    var footage: Footage
    
    init(
        uid: UUID,
        name: String,
        footage: Footage)
    {
        self.uid = uid
        self.name = name
        self.footage = footage
    }
}

// MARK: - Mock Data
extension FootageTag {
    static let mock: FootageTag = FootageTag(
        uid: UUID(),
        name: "reef",
        footage: Footage.mock
    )

    static var mockArray: [FootageTag] {
        (0..<Int.random(in: 3...10)).map { _ in
            FootageTag(
                uid: UUID(),
                name: ["reef","training","deep","nursery","survey"].randomElement()!,
                footage: Footage.mockArray.randomElement() ?? Footage.mock
            )
        }
    }
}
