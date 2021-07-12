//
//  ForecastWeatherViewModelTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import XCTest

class ForecastWeatherViewModelTests: XCTestCase {
    
    //MARK: - Variables
    var sut: ForecastWeatherViewModel!
    var dataManager: MockDataManager<ForecastWeather>!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        dataManager = MockDataManager()
        sut = ForecastWeatherViewModel(dataManager: dataManager)
    }
    
    //MARK: - Tests
    func testFetchFetchWeather() {
        
        //Given
        let emptyWeatherModel = Weather(weather: nil, base: nil, main: nil,
                                        visibility: nil, wind: nil, rain: nil,
                                        date: nil, id: nil, name: nil)
        let emptyModel = ForecastWeather(code: nil, message: nil, count: nil,
                                         list: [emptyWeatherModel])
        dataManager.model = emptyModel
        
        //When
        sut.fetchForecastWeather()
        
        //Then
        XCTAssertTrue(dataManager.isDataFetched, "Data should be fetched")
    }
    
    func testFetchTracksFail() {
        
        //Given
        let error = NetworkError.noData
        
        //When
        sut.fetchForecastWeather()
        dataManager.fetchWithError(error)
        
        //Then
        XCTAssertEqual(sut.error.value?.description, error.description,
                       "Both errors should be equal.")
    }
    
    
    func testSuccessfulFetchForecastWeather() {
        
        //Given
        let forecastWeather: ForecastWeather = FileLoader.readDataFromFile(at: "forecast_weather_data")
        dataManager.model = forecastWeather
        let expectation = XCTestExpectation(description: "Reload tableView triggered")
        sut.shouldReloadData.bind { success in
            if success { expectation.fulfill() }
        }
        
        //When
        sut.fetchForecastWeather()
        dataManager.fetchWithSuccess()
        
        //Then
        XCTAssertTrue(forecastWeather.list?.count ?? 0 > 0, "Forecast weather data should be there.")
        let weather = forecastWeather.list?[0]
        XCTAssertEqual(weather?.weather?[0].id, 500, "Weather ids should be equal.")
        XCTAssertEqual(weather?.wind?.deg, 244, "Weather wind degrees should be equal.")
        XCTAssertEqual(weather?.main?.temparature, 25.3, "Weather temp.s should be equal.")

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingStatusWhileFetching() {
        
        //Given
        var loading = false
        let expectation = XCTestExpectation(description: "Loading status updated")
        sut.isLoading.bind { (success) in
            loading = success
            expectation.fulfill()
        }
        
        //When
        sut.fetchForecastWeather()
        
        //Assert
        XCTAssert(loading)
        
        //When finished fetching
        dataManager.fetchWithSuccess()
        
        //Assert
        XCTAssertFalse(loading)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
