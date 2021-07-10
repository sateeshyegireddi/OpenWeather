//
//  MockDataManager.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import Foundation
import XCTest
@testable import OpenWeather

class MockDataManager<T: Codable> {
    
    //MARK: - Variables
    var handler: ((T?, NetworkError?) -> ())!
    var isDataFetched = false
    
    //MARK: - Success
    func fetchWithSuccess(_ data: T?) {
        handler(data, nil)
    }
    
    //MARK: - Failure
    func fetchWithError(_ error: NetworkError?) {
        handler(nil, error)
    }
}

extension MockDataManager: Fetchable {
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ()) {
        isDataFetched = true
        self.handler = handler as? (Codable?, NetworkError?) -> ()
    }
}
