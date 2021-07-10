//
//  EndPoint.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import Foundation

/// `EndPoint` defines base URL, all paths and queries.
enum EndPoint: Hashable {
    //Base url
    case baseURL
    case appId
        
    //Today's forecast
    case todayForecast
    case latitude
    case longitude
    case units
    
    //Five days forecast
    case fiveDaysForecast
}

extension EndPoint {
    var rawValue: String {
        switch self {
        //Base url
        case .baseURL:
            return "http://api.openweathermap.org/data/2.5/"
        case .appId:
            return "appid"
        
        //Today's forecast
        case .todayForecast:
            return "weather"
        case .latitude:
            return "lat"
        case .longitude:
            return "lon"
        case .units:
            return "units"

        //Five days forecast
        case .fiveDaysForecast:
            return "forecast"
        }
    }
}
