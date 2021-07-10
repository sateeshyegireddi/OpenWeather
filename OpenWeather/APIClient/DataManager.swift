//
//  DataManager.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import Foundation

/// `DataManager` is an abstract type, used to parse the `Result` data from the server.
struct DataManager {}

/// `Fetchable` defines the mandatory functionality for handling success or failure cases of response.
protocol Fetchable {
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ())
}

extension DataManager: Fetchable {
    
    /// It is an abstract method, send the request to `APIClient` and handles the response received from it.
    /// - Parameters:
    ///   - request: A request to be passed to server.
    ///   - handler: A closure which holds data and error which is received from server.
    ///   - data: A model data of type `T`, which is received from API.
    ///   - error: An error received from service call.
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ()) {
        APIClient.send(request) { (result: Result<T, NetworkError>) in
            switch result {
            case .success(let data):
                handler(data, nil)
            case .failure(let failError):
                handler(nil, failError)
            }
        }
    }
}
