//
//  APICalling.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import Foundation
import SystemConfiguration

enum Errors: Error {
    case errorDefault
}

class APICalling {
    
    static var lastFlag: Bool = true
    static var timer: Timer?
    
    func fetch<T: Codable>(apiRequest: APIRequest, callBack: @escaping (Result<T, Error>) -> Void) {
        
        let request = apiRequest.request(with: apiRequest.baseURL)
        
        let urlConfiguration = URLSessionConfiguration.default
        urlConfiguration.waitsForConnectivity = true
        urlConfiguration.timeoutIntervalForRequest = 12
        urlConfiguration.timeoutIntervalForResource = 12
        
        let urlSession = URLSession(configuration: urlConfiguration)
                
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode <= 200,
            error == nil, let data = data  else {
                callBack(.failure(error ?? Errors.errorDefault))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                callBack(.success(model))
                
            } catch let error {
                callBack(.failure(error))
            }
        }
        task.resume()
    }
}
