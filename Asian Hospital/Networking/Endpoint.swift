//
//  Endpoint.swift
//  Mod
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

/// A type that provides URLRequests for defined API endpoints
protocol Endpoint {
    /// Returns the base URL for the API as a string
    var base: String { get }
    /// Returns the URL path for an endpoint, as a string
    var path: String { get }
    /// Returns the URL parameters for a given endpoint as an array of URLQueryItem
    /// values
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    /// Returns an instance of URLComponents containing the base URL, path and
    /// query items provided
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    /// Returns an instance of URLRequest encapsulating the endpoint URL. This
    /// URL is obtained through the `urlComponents` object.
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
    
    typealias HttpBody = Dictionary<String, Any>
    
    func requestWithHttpBody(_ httpBody: HttpBody) -> URLRequest {
        var requestWithBody = request
        
        let data = try! PropertyListSerialization.data(fromPropertyList: httpBody, format: .binary, options: 0)
        
        requestWithBody.httpMethod = "POST"
        requestWithBody.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        requestWithBody.httpBody = data
        
        return requestWithBody
    }
    
    func requestWithAuthorizationHeader(oauthToken: String) -> URLRequest {
        var oauthRequest = request
        
        oauthRequest.addValue("Bearer \(oauthToken)", forHTTPHeaderField: "Authorization")
        
        return oauthRequest
    }
}

enum HopprLab {
    enum DoctorSortType: CustomStringConvertible {
        case name
        case department
        
        var description: String {
            switch self {
            case .name: return "name"
            case .department: return "department"
            }
        }
    }
    
    case requestToken
    case searchDoctor(term: String, limit: Int?, sortBy: DoctorSortType?)
}

extension HopprLab: Endpoint {
    var base: String {
        return "https://hopprLab.com"
    }

    var path: String {
        switch self {
            case .searchDoctor: return "/openAPI/Doctor/Info"
            case .requestToken: return "/token"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
            case .searchDoctor(let term, let limit, let sortBy):
                return [
                    URLQueryItem(name: "term", value: term),
                    URLQueryItem(name: "limit", value: limit?.description),
                    URLQueryItem(name: "sort_by", value: sortBy?.description)
                ]
            case .requestToken: return []
        }
    }
}

