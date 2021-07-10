//
//  EndPointTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import XCTest
@testable import OpenWeather

class EndPointTests: XCTestCase {
    
    //MARK: - Variables
    var sut: EndPoint!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = EndPoint.baseURL
    }
    
    //MARK: - Tests
    func testSuccessfulError() {
        sut = EndPoint.baseURL
        XCTAssertNotNil(sut.rawValue, "Base URL should be there.")
        sut = EndPoint.appId
        XCTAssertNotNil(sut.rawValue, "App ID should be there.")
        sut = EndPoint.todayForecast
        XCTAssertNotNil(sut.rawValue, "Today's forecast should be there.")
        sut = EndPoint.latitude
        XCTAssertNotNil(sut.rawValue, "Latitude should be there.")
        sut = EndPoint.longitude
        XCTAssertNotNil(sut.rawValue, "Longitude should be there.")
        sut = EndPoint.units
        XCTAssertNotNil(sut.rawValue, "Units should be there.")
        sut = EndPoint.fiveDaysForecast
        XCTAssertNotNil(sut.rawValue, "Five days forecast should be there.")
    }
    
    func testFailureError() {
        sut = EndPoint.baseURL
        XCTAssertNotEqual(sut.rawValue, "empty", "Base URL shouldn't be empty.")
        sut = EndPoint.appId
        XCTAssertNotEqual(sut.rawValue, "empty", "App ID shouldn't be empty.")
        sut = EndPoint.todayForecast
        XCTAssertNotEqual(sut.rawValue, "empty", "Today's forecast shouldn't be empty.")
        sut = EndPoint.latitude
        XCTAssertNotEqual(sut.rawValue, "empty", "Latitude shouldn't be empty.")
        sut = EndPoint.longitude
        XCTAssertNotEqual(sut.rawValue, "empty", "Longitude shouldn't be empty.")
        sut = EndPoint.units
        XCTAssertNotEqual(sut.rawValue, "empty", "Units shouldn't be empty.")
        sut = EndPoint.fiveDaysForecast
        XCTAssertNotEqual(sut.rawValue, "empty", "Five days forecast shouldn't be empty.")

    }
    
    //MARK: - Teardown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

