//
//  AddLocationViewModel.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import Foundation
import CoreLocation

class AddLocationViewModel {

    //MARK: - Properties
    private(set) var locations = Observable<[Location]>([])
    var bookmarkLocation = Observable<Location?>(nil)
    private var bookmarkedLocation = BookmarkedLocation()
    var bookmarkedLocations = Observable<[Location]>([])
    
    //MARK: - Init
    init(_ locations: Observable<[Location]> = .init([])) {
        self.locations = locations
        bookmarkedLocations.value = bookmarkedLocation.getLocations()
    }
    
    //MARK: - Update
    func updateBookmarkLocation(_ coordinate: CLLocationCoordinate2D?) {
        let location = CLLocation(latitude: coordinate?.latitude ?? 0,
                                  longitude: coordinate?.longitude ?? 0)
        location.fetchCityAndCountry { (city, country, error) in
            let newLocation = Location(latitude: coordinate?.latitude ?? 0.0,
                                       longitude: coordinate?.longitude ?? 0.0,
                                       name: city ?? "")
            self.bookmarkLocation.value = newLocation
        }
    }
    
    func updateLocations(_ locations: [CLLocation]) {
        let locations = locations.map { Location(latitude: $0.coordinate.latitude,
                                                 longitude: $0.coordinate.longitude) }
        self.locations.value = locations
    }
    
    //MARK: - Bookmarked Locations
    func saveBookmarkedLocation() {
        if let location = bookmarkLocation.value {
            bookmarkedLocation.saveLocation(location)
            bookmarkedLocations.value = bookmarkedLocation.getLocations()
        }
    }

    func fetchBookmarkedLocations() {
        bookmarkedLocations.value = bookmarkedLocation.getLocations()
    }
    
    func removeBookmarkedLocation(_ location: Location) {
        bookmarkedLocation.removeLocation(location)
        bookmarkedLocations.value = bookmarkedLocation.getLocations()
    }
}
