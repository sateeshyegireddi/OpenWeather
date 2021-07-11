//
//  AddLocationViewModelTests.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import XCTest
import CoreLocation

class AddLocationViewModelTests: XCTestCase {
    
    //MARK: - Variables
    var sut: AddLocationViewModel!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = AddLocationViewModel()
    }
    
    //MARK: - Tests
    func testLocations() {
        
        //Given
        let locations = [CLLocation(latitude: 17.232, longitude: 83.45),
                         CLLocation(latitude: 17.232, longitude: 79.45)]
        
        //When
        sut.updateLocations(locations)
        
        //Then
        XCTAssertEqual(sut.locations.value.count, 2,
                       "Both locations number should be same.")
        let location = sut.locations.value[0]
        XCTAssertEqual(locations[0].coordinate.latitude, location.latitude,
                       "Both latitudes should be same.")
        XCTAssertEqual(locations[0].coordinate.longitude, location.longitude,
                       "Both longitudes should be same.")
    }
    
    func testBookmarkedLocation() {
        
        //Given
        let coordinate = CLLocationCoordinate2DMake(17.232, 83.45)
        let expectation = XCTestExpectation(description: "Bookmarks updated")
        var bookmark: Location? = nil
        sut.bookmarkLocation.bind { location in
            bookmark = location
            expectation.fulfill()
        }
        
        //When
        sut.updateBookmarkLocation(coordinate)
        
        //Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(bookmark, "Updated bookmark should not be nil.")
        XCTAssertEqual(bookmark?.latitude, coordinate.latitude,
                       "Both latitudes should be same.")
        XCTAssertEqual(bookmark?.longitude, coordinate.longitude,
                       "Both longitudes should be same.")
    }
    
    //MARK: - Teardown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
