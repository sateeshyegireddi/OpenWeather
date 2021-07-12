//
//  Units.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import Foundation

enum Unit: String, RawRepresentable {
    case metric
    case imperial
    
    init?(rawValue: String) {
        switch rawValue {
        case "metric":
            self = .metric
        case "imperial":
            self = .imperial
        default:
            self = .metric
        }
    }
}
