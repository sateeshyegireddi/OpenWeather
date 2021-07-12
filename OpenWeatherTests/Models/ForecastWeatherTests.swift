//
//  ForecastWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import XCTest

class ForecastWeatherTests: XCTestCase {

    //MARK: - Variables
    var weather: ForecastWeather!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
    }

    //MARK: - Tests
    func testForecastWeatherModel() {
        let forecastWeather: ForecastWeather = FileLoader.readDataFromFile(at: "forecast_weather_data")
        XCTAssertNotNil(forecastWeather, "Weather should not be nil.")
        XCTAssertTrue(forecastWeather.list?.count ?? 0 > 0, "Forecast weather data should be there.")
        let weather = forecastWeather.list?[0]
        XCTAssertEqual(weather?.weather?[0].id, 500, "Weather ids should be equal.")
        XCTAssertEqual(weather?.wind?.deg, 244, "Weather wind degrees should be equal.")
        XCTAssertEqual(weather?.main?.temparature, 25.3, "Weather temp.s should be equal.")
    }

    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
    }
}
