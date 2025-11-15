//
//  Location.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 06/11/25.
//

import Foundation
import SwiftData

@Model
final class Location {
    @Attribute(.unique) var uid: UUID
    var name: String
    
    init(
        uid: UUID = .init(),
        name: String)
    {
        self.uid = uid
        self.name = name
    }
}

// MARK: - Mock Data
extension Location {
    static var mockArray: [Location] {
        (0..<Int.random(in: 3...10)).map { _ in
            Location(name: ["Nusa Dua","Menjangan","Tulamben","Amed"].randomElement()!)
        }
    }
}
