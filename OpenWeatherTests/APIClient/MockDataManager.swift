//
//  MockDataManager.swift
//  OpenWeatherTests
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import Foundation
import XCTest
@testable import OpenWeather

class MockDataManager<U: Codable>: Fetchable {
    
    //MARK: - Variables
    var handler: ((U?, NetworkError?) -> ())!
    var isDataFetched = false
    var model: U? = nil
    
    //MARK: - Success
    func fetchWithSuccess() {
        handler(model, nil)
    }
    
    //MARK: - Failure
    func fetchWithError(_ error: NetworkError?) {
        handler(nil, error)
    }
    
    //MARK: - API
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ()) {
        isDataFetched = true
        self.handler = { (data: U?, error: NetworkError?) in
            handler(data as? T, error)
        }
    }
}
