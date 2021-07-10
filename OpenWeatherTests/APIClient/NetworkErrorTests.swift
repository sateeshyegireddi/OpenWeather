//
//  NetworkErrorTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import XCTest
@testable import OpenWeather

class NetworkErrorTests: XCTestCase {
    
    //MARK: - Variables
    private var sut: NetworkError!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = NetworkError.request
    }
    
    //MARK: - Tests
    func testSuccessfulError() {
        sut = NetworkError.request
        XCTAssertNotNil(sut.description, "Request error should be there.")
        sut = NetworkError.server
        XCTAssertNotNil(sut.description, "Server error should be there.")
        let url = URL(string: "https://www.domain.com")!
        sut = NetworkError.invalidURL(url)
        XCTAssertNotNil(sut.description, "URL invalid message should be there.")
        sut = NetworkError.noData
        XCTAssertNotNil(sut.description, "No data message should be there.")
        sut = NetworkError.jsonParse
        XCTAssertNotNil(sut.description, "JSON parsing message should be there.")
        sut = NetworkError.genericError("Error")
        XCTAssertNotNil(sut.description, "Generic error message should be there.")
    }
    
    func testFailureError() {
        sut = NetworkError.request
        XCTAssertNotEqual(sut.description, "empty", "Request error shouldn't be empty.")
        sut = NetworkError.server
        XCTAssertNotEqual(sut.description, "empty", "Server error shouldn't be empty.")
        let url = URL(string: "https://www.domain.com")!
        sut = NetworkError.invalidURL(url)
        XCTAssertNotEqual(sut.description, "empty", "URL invalid message shouldn't be empty.")
        sut = NetworkError.noData
        XCTAssertNotEqual(sut.description, "empty", "No data message shouldn't be empty.")
        sut = NetworkError.jsonParse
        XCTAssertNotEqual(sut.description, "empty", "JSON parsing message shouldn't be empty.")
        sut = NetworkError.genericError("Error")
        XCTAssertNotEqual(sut.description, "empty", "Generic error message shouldn't be empty.")
    }

    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

