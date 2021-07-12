//
//  ForecastWeatherViewModel.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import Foundation

class ForecastWeatherViewModel {
    
    //MARK: - Variables
    private var weather = Observable<ForecastWeather?>(nil)
    private var dataManager: Fetchable
    var isLoading = Observable<Bool>(false)
    var error = Observable<NetworkError?>(nil)
    var shouldReloadData = Observable<Bool>(false)
    private var location = Location()
    var weathersFormatted = Observable<[WeatherFormatted]>([])
    private var weatherViewModel = WeatherViewModel()
    @LocalStorage(key: "units_type") var units: String? = nil

    //MARK: - Init
    init(dataManager: Fetchable = DataManager(),
         location: Location = Location()) {
        self.dataManager = dataManager
        self.location = location
    }
}

//MARK: - Networking
extension ForecastWeatherViewModel {
    func fetchForecastWeather() {
        //Create request
        var request = WeatherRequest()
        request.parameters = [.latitude: "\(location.latitude)",
                              .longitude: "\(location.longitude)",
                              .units: Unit(rawValue: units ?? "")?.rawValue ?? ""]
        
        //Send data to server
        isLoading.value = true
        dataManager.fetchData(with: request) { (weather: ForecastWeather?,
                                                error: NetworkError?) in
            self.isLoading.value = false
            if let weather = weather {
                self.weather.value = weather
                if let weathers = weather.list {
                    self.weathersFormatted.value = weathers.map {
                        self.weatherViewModel.formatWeather($0)
                    }
                }
            } else if let error = error {
                self.error.value = error
            }
            self.shouldReloadData.value = true
        }
    }
}

private struct WeatherRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .fiveDaysForecast
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}

