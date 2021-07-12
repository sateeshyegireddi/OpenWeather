//
//  ForecastWeather.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import Foundation

struct ForecastWeather: Codable {
    var code: String?
    var message: Int?
    var count: Int?
    var list: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message = "message"
        case count = "cnt"
        case list = "list"
    }
}
