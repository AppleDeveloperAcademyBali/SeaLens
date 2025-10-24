//
//  MockNetworkService.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 24/10/2025.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    
    // fake response that mock returns
    var mockResponse: String?
    
    // stimulate a network failure
    var shouldFail: Bool = false
    
    // stimalating the error to throw when server fails
    var errorToThrow: NetworkServiceError = .noData
    
    init(mockResponse: String? = nil, shouldFail: Bool = false) {
        self.mockResponse = mockResponse
        self.shouldFail = shouldFail
    }
    
    
    // MARK: - Server Health Check
    func checkServerHealth() async throws -> String {
        
        // stimulate network latency (0.1 s)
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // throw a fake error if we are told to stimulate a failure
        if shouldFail {
            throw errorToThrow
        }
        
        // if no mock response was provided, throw a "no data" error
        guard let response = mockResponse else {
            throw NetworkServiceError.noData
        }
        
        // return response
        return response
        
    }
    
    
    
}
