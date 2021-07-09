//
//  NetworkError.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import Foundation

/// `NetworkError` defines all the errors which are encountered while making the request to API, fetch and parse data from server.
enum NetworkError: Error, CustomStringConvertible {
    case request
    case server
    case noNetwork
    case invalidURL(URL)
    case noData
    case jsonParse
    case genericError(Any)
    
    var description: String {
        switch self {
        case .request:
            return "The request failed due to an error in the request."
        case .server:
            return "The request failed due to a server-side error."
        case .noNetwork:
            return "It seems the device is not connected to internet. Please check your internet connection."
        case .invalidURL(let url):
            return "Invalid URL: \(url)."
        case .noData:
            return "No Data received from the server."
        case .jsonParse:
            return "There is an error occured while parsing JSON data."
        case .genericError(let any):
            return "Error occured: \(any)"
        }
    }
}
