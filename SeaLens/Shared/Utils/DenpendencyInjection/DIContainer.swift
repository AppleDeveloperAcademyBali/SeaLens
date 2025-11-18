//
//  DIContainer.swift
//  SeaLens
//
//  Created by Handy Handy on 16/11/25.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    
    private var factories: [ObjectIdentifier: () -> Any] = [:]
    private let queue = DispatchQueue(label: "di.container.queue", attributes: .concurrent)
    
    private init() { }
    
    func register<Service>(_ type: Service.Type, factory: @escaping () -> Service) {
        let key = ObjectIdentifier(type)
        queue.async(flags: .barrier) {
            self.factories[key] = factory
        }
    }
    
    func resolve<Service>(_ type: Service.Type = Service.self) -> Service {
        let key = ObjectIdentifier(type)
        
        return queue.sync {
            guard let factory = factories[key]?() as? Service else {
                fatalError("No registration for \(type)")
            }
            return factory
        }
    }
}
