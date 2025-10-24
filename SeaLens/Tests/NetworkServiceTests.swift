//
//  NetworkServiceTests.swift
//  SeaLensTests
//
//  Created by Shreyas Venadan on 22/10/2025.
//

import XCTest
@testable import SeaLens

final class NetworkServiceTests: XCTestCase {
    
    // sut = system under test
    var sut: NetworkService!

    override func setUpWithError() throws {
        super.setUp()
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test When Server Is Healthy
    func testServerHealthSuccess() async throws {
        
        let mockService = MockNetworkService(mockResponse: "status: Healthy Server")
        
        let result = try await mockService.checkServerHealth()
        
        XCTAssertEqual(result, "status: Healthy Server")

    }

    // MARK: - Test When Server Fails
    func testServerHealthFailure() async {
        
        let mockService = MockNetworkService(shouldFail: true)
        mockService.errorToThrow = .httpError(statusCode: 500)
                
        do {
            _ = try await mockService.checkServerHealth()
            
            // if server does not throw an error (and then go to catch), then it will fail here with this message
            XCTFail("Expected an error to be thrown, but the call succeded")
            
        } catch {
            if case NetworkServiceError.httpError(let code) = error {
                
                // checking if error matches the one we sent
                XCTAssertEqual(code, 500, "Expected a 500 HTTP error")
                
            } else {
                
                // if any other type of error, we display the errowr
                XCTFail("Unexpected error type: \(error)")
            }
            
        }

    }
    
    
    





}
