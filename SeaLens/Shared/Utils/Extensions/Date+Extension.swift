//
//  Date+Extension.swift
//  SeaLens
//
//  Created by Handy Handy on 20/11/25.
//

import Foundation

extension Date {
    func formatCreationDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
