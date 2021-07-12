//
//  APIClient.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import Foundation

/// `APIClient` is used to send the request data to API and get the response from server.
/// If the service call succeds, it fetches and parses the data received from server to a given model.
/// If the service call fails, it returns the associated error.
struct APIClient {
    
    /// Requests the API with associated data and fetch information from server.
    /// - Parameters:
    ///   - urlRequest: `APIRequest` which contains end point, parameters.
    ///   - completion: A closure which is called as soon as data has been received from server.
    ///   - result: Contains the model and error data. `Result<T, NetworkError>` where `T` is generic type of the model.
    static func send<T: Codable>(_ urlRequest: APIRequest,
                                 completion: @escaping (_ result:  Result<T, NetworkError>) -> ()) {
        
        //Create request with given baseURL
        let request = urlRequest.request()
        
        //Create the Session Configuration with default/ephimeral type
        let configuration = URLSessionConfiguration.default
        
        //Set its time-out interval to certain seconds
        configuration.timeoutIntervalForRequest = 30
        
        //Create the session with created configuration
        let session = URLSession(configuration: configuration)
        
        //Create dataTask with the specific request
        let task = session.dataTask(with: request) { (data, response, error) in
            
            #if DEBUG
            let httpUrlResponse = response as? HTTPURLResponse
            self.logSession(log: true,
                            request: request,
                            response: httpUrlResponse,
                            error: error,
                            data: data)
            #endif
            
            //Return if there is any error from server
            if let error = error {
                completion(Result.failure(NetworkError.genericError(error.localizedDescription)))
                return
            }
            
            //Return if there is no data received from server
            guard let data = data else {
                completion(Result.failure(NetworkError.noData))
                return
            }
            
            //Parse data and return associate model or JSON parse failure error.
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(model))
            } catch {
                completion(Result.failure(NetworkError.jsonParse))
            }
        }
        
        //Resume the task if its not started or suspended.
        task.resume()
    }
    
    /// Log the whole session data in the console.
    /// - Parameters:
    ///   - log: Enable / Disable the log
    ///   - request: `URLRequest` which contains end point, parameters.
    ///   - response: An object that provides response metadata, such as`HTTP` headers and status code. If you are making an `HTTP` or `HTTPS` request, the returned object is actually an `HTTPURLResponse` object.
    ///   - error: An error object that indicates why the request failed, or nil if the request was successful.
    ///   - data: The data returned by the server.
    static func logSession(log: Bool,
                    request: URLRequest?,
                    response: HTTPURLResponse?,
                    error: Error?,
                    data: Data?) {
        if log == false && error == nil && (200..<300).contains(response?.statusCode ?? 0) {
            return
        }
        if request != nil, let url = request?.url?.absoluteURL {
            print("\(request?.httpMethod ?? "URL"):\t\t\(url)")
        }
        if let headers = request?.allHTTPHeaderFields, !headers.isEmpty {
            print("Header:\t\t\(headers)")
        }
        if let data = request?.httpBody, !data.isEmpty {
            print("Body:\t\tSize: \(data)\n\(data.prettyPrittedString)")
        }
        if let statusCode = response?.statusCode {
            print("Status Code: \t\(statusCode)")
        }
        if let data = data, !data.isEmpty {
            print("Response:\t\tSize: \(data)\n\(data.prettyPrittedString.replacingOccurrences(of: "\\/", with: "/"))")
        }
        if let error = error {
            print("Error:\t\t\(error.localizedDescription)")
        }
    }
}
