//
//  NetworkServiceProtocol.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 24/10/2025.
//

protocol NetworkServiceProtocol {
    func checkServerHealth() async throws -> String
}
