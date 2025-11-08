//
//  String+Extension.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation

extension String {
    
    // MARK: - Check numeric in the depth
    func isNumeric() -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
}
