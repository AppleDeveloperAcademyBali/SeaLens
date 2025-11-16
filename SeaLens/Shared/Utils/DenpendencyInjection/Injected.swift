//
//  Injected.swift
//  SeaLens
//
//  Created by Handy Handy on 16/11/25.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service
    
    init() {
        self.service = DIContainer.shared.resolve(Service.self)
    }
    
    var wrappedValue: Service {
        get { service }
        mutating set { service = newValue }
    }
}
