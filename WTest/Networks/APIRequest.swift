//
//  APIRequest.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import Foundation

class APIRequest {
    var baseURL: URL!
    var method = "GET"
    var parameters = [String: String]()
    
    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.allHTTPHeaderFields = ["Accept" : "application/json"]
        return request
    }
}
