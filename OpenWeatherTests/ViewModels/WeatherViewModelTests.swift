//
//  WeatherViewModelTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import XCTest

class WeatherViewModelTests: XCTestCase {
    
    //MARK: - Variables
    var sut: WeatherViewModel!
    var dataManager: MockDataManager<Weather>!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        dataManager = MockDataManager()
        sut = WeatherViewModel(dataManager: dataManager)
    }
    
    //MARK: - Tests
    func testFetchWeather() {
        
        //Given
        let emptyModel = Weather(weather: nil, base: nil, main: nil, visibility: nil,
                                 wind: nil, rain: nil, date: nil, id: nil, name: nil)
        dataManager.model = emptyModel
        
        //When
        sut.fetchWeather()
        
        //Then
        XCTAssertTrue(dataManager.isDataFetched, "Data should be fetched")
    }
    
    func testFetchTracksFail() {
        
        //Given
        let error = NetworkError.noData
        
        //When
        sut.fetchWeather()
        dataManager.fetchWithError(error)
        
        //Then
        XCTAssertEqual(sut.error.value?.description, error.description,
                       "Both errors should be equal.")
    }
    
    
    func testSuccessfulFetchWeather() {
        
        //Given
        let weather: Weather = FileLoader.readDataFromFile(at: "weather_data")
        dataManager.model = weather
        let expectation = XCTestExpectation(description: "Reload tableView triggered")
        sut.shouldReloadData.bind { success in
            if success { expectation.fulfill() }
        }
        
        //When
        sut.fetchWeather()
        dataManager.fetchWithSuccess()
        
        //Then
        let temparature = "\(Int(weather.main?.temparature ?? 0.0)) º"
        XCTAssertEqual(sut.weatherFormatted.value?.temparature, temparature)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingStatusWhileFetching() {
        
        //Given
        var loading = false
        let expectation = XCTestExpectation(description: "Loading status updated")
        sut.isLoading.bind { [weak self] (success) in
            loading = self?.sut.isLoading.value ?? false
            expectation.fulfill()
        }
        
        //When
        sut.fetchWeather()
        
        //Assert
        XCTAssert(loading)
        
        //When finished fetching
        dataManager.fetchWithSuccess()
        
        //Assert
        XCTAssertFalse(loading)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFormattedWeather() {
        let weather: Weather = FileLoader.readDataFromFile(at: "weather_data")
        let weatherFormatted = sut.formatWeather(weather)
        let temparature = "\(Int(weather.main?.temparature ?? 0.0)) º"
        XCTAssertEqual(weatherFormatted.temparature, temparature, "Both temp.s should be equal.")
    }
    
    //MARK: - Tear down
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

