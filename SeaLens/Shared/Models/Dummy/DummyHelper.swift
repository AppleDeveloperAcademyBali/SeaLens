//
//  DummyHelper.swift
//  SeaLens
//
//  Created by Handy Handy on 15/11/25.
//

import Foundation
import SwiftData

extension Date {
    static func randomDaysAgo(_ days: Int) -> Date {
        Date().addingTimeInterval(-Double(days * 86_400))
    }
}

extension UUID {
    static func randomString() -> String {
        String(UUID().uuidString.prefix(8))
    }
}


