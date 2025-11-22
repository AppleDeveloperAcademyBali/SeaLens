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
    
    @Transient var sites: [Site] = []
    
    init(
        uid: UUID = .init(),
        name: String)
    {
        self.uid = uid
        self.name = name
    }
}

// MARK: - Location
extension Location {
    static func mock(in context: ModelContext, name: String? = nil) -> Location {
        let obj = Location(uid: UUID(), name: name ?? ["Nusa Dua","Menjangan","Tulamben","Amed"].randomElement()!)
        context.insert(obj)
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 3...6)) -> [Location] {
        (0..<count).map { _ in mock(in: context) }
    }
}
