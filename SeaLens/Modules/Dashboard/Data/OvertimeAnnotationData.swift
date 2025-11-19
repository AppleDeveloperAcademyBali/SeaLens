//
//  AnnotationData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 19/11/25.
//

import Foundation
import SwiftUI

struct OvertimeAnnotationData: Equatable {
    let point: DateDataPoint
    let family: String
    let color: Color
    let position: CGPoint
    
    static func == (lhs: OvertimeAnnotationData, rhs: OvertimeAnnotationData) -> Bool {
        return lhs.point.date == rhs.point.date &&
               lhs.point.value == rhs.point.value &&
               lhs.family == rhs.family &&
               lhs.position == rhs.position
    }
}
