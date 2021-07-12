//
//  Location.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import Foundation

struct Location: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let name: String
    
    init(latitude: Double = 0.0, longitude: Double = 0.0, name: String = "") {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.name == rhs.name
    }
}

struct BookmarkedLocation {
    @LocalStorage(key: "book_marked_locations") var savedLocationsData: Data? = nil
    
    //MARK: - Retrive
    func getLocations() -> [Location] {
        var locations = [Location]()
        
        //Create JSONDecoder
        let decoder = JSONDecoder()
        
        //Retrive from and UserDefaults decode data to Location models
        if let data = savedLocationsData,
           let savedLocations = try? decoder.decode([Location].self,
                                                    from: data) {
            locations = savedLocations
        }
        
        return locations
    }
    
    //MARK: - Save
    mutating func saveLocation(_ location: Location) {
        
        //Fetch locations from UserDefaults and append bookmarked location
        var locations = getLocations()
        locations.append(location)
        
        //Create JSONDecoder
        let encoder = JSONEncoder()

        //Encode Location and save it in UserDefaults
        if let data = try? encoder.encode(locations) {
            savedLocationsData = data
        }
    }
    
    //MARK: - Remove
    mutating func removeLocation(_ location: Location) {
        
        //Fetch locations from UserDefaults and append bookmarked location
        var locations = getLocations()
        locations = locations.filter { $0 != location }
        
        //Create JSONDecoder
        let encoder = JSONEncoder()

        //Encode Location and save it in UserDefaults
        if let data = try? encoder.encode(locations) {
            savedLocationsData = data
        }
    }
    
    mutating func removeAll() {
        savedLocationsData = nil
    }
}
