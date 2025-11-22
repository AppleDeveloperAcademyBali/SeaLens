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

// MARK: - Site
extension Site {
    static func mock(in context: ModelContext, name: String? = nil) -> Site {
        let obj = Site(uid: UUID(), name: name ?? "Site \(Int.random(in: 1...10))")
        context.insert(obj)
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 2...6)) -> [Site] {
        (0..<count).map { _ in mock(in: context) }
    }
}
