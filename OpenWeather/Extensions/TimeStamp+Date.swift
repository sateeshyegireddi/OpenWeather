//
//  TimeStamp+Date.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import Foundation

extension Double {
    func getDateStringFromUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
