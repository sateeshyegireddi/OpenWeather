//
//  TimeStamp+Date.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import Foundation

extension Int {
    func getDateStringFromUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd | hh:mm a" //Mon 12 | 06:00 PM
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
