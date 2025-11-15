//
//  Site.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class Site {
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
extension Site {
    static var mockArray: [Site] {
        (0..<Int.random(in: 3...10)).map { _ in
            Site(name: "Site \(Int.random(in: 1...10))")
        }
    }
}
