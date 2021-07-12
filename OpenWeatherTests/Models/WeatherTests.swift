//
//  WeatherTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import XCTest

class WeatherTests: XCTestCase {
    
    //MARK: - Variables
    var weather: Weather!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
    }

    //MARK: - Tests
    func testWeatherModel() {
        let weather: Weather = FileLoader.readDataFromFile(at: "weather_data")
        XCTAssertNotNil(weather, "Weather should not be nil.")
        XCTAssertEqual(weather.weather?[0].id, 502, "Weather ids should be equal.")
        XCTAssertEqual(weather.wind?.deg, 200, "Weather wind degrees should be equal.")
        XCTAssertEqual(weather.main?.temparature, 25.02, "Weather temp.s should be equal.")
    }

    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
    }
}
