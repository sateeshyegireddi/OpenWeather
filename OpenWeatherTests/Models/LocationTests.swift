//
//  LocationTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import XCTest

class LocationTests: XCTestCase {

    //MARK: - Variables
    var sut: Location!
        
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = Location()
    }
    
    //MARK: - Tests
    func testSuccessfulLocation() {
        sut = Location(latitude: 17.7666,
                       longitude: 83.3343,
                       name: "Hyderabad")
        XCTAssertNotNil(sut, "Location object should be there.")
        XCTAssertNotNil(sut.latitude, "Latitude should be there.")
        XCTAssertEqual(sut.latitude, 17.7666, "Both Latitudes should be same.")
        XCTAssertNotNil(sut.longitude, "Longitude should be there.")
        XCTAssertEqual(sut.longitude, 83.3343, "Both Longitudes should be same.")
        XCTAssertNotNil(sut.name, "City name should be there.")
        XCTAssertEqual(sut.name, "Hyderabad", "Both City names should be same.")
        let duplicateSut = sut
        XCTAssertTrue(duplicateSut == sut, "Both locations should be same")
    }
    
    func testFailureLocation() {
        sut = Location(latitude: 17.7666,
                       longitude: 83.3343,
                       name: "Hyderabad")
        XCTAssertNotNil(sut, "Location object should be there.")
        XCTAssertNotEqual(sut.latitude, 0, "Both Latitudes should be same.")
        XCTAssertNotEqual(sut.longitude, 0, "Both Longitudes should be same.")
        XCTAssertNotEqual(sut.name, "Mumbai", "Both City names should be same.")
        let duplicateSut = sut
        XCTAssertFalse(duplicateSut != sut, "Both locations should be same")
    }
    
    //MARK: - Teardown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
