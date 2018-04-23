//
//  Endpoint.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

public typealias Parameters = Dictionary<String, Any>

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
    
    func request(with parameters: Parameters) -> URLRequest {
        var requestWithParams = request
        
        var paramString = ""
        
        for (key, value) in parameters {
            if let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let escapedValue = (value as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
        }
        
        requestWithParams.httpMethod = HTTPMethod.post.rawValue
        requestWithParams.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        requestWithParams.httpBody = paramString.data(using: .utf8)
        
        return requestWithParams
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
    
    // Patient
    case requestToken
    case requestdumpingStatus(username: String)
    case sendUserAction
    case requestPatientInformation(type: PatientInformationType, username: String)
    case requestBillingInformation(username: String)
    // Doctor
    case searchDoctor(term: String, limit: Int?, sortBy: DoctorSortType?)
}

extension HopprLab: Endpoint {
    var base: String {
        return "https://hopprLab.com"
    }

    var path: String {
        switch self {
        case .requestToken: return "/openAPI/token"
        case .requestdumpingStatus(let username): return "/openAPI/CheckDumpingStatus/\(username)"
        case .sendUserAction: return "/openAPI/Audit/PostUserActions"
        case .requestPatientInformation(let type, _): return "/openAPI/\(type.path)"
        case .requestBillingInformation(let username): return "/openAPI/GetPatientBill/\(username)"
        case .searchDoctor: return "/openAPI/Doctor/Info"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .requestToken: return []
        case .requestdumpingStatus: return []
        case .sendUserAction: return []
        case .requestPatientInformation(_, let username):
            return [
                URLQueryItem(name: "hn", value: username)
            ]
        case .requestBillingInformation: return []
        case .searchDoctor(let term, let limit, let sortBy):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "limit", value: limit?.description),
                URLQueryItem(name: "sort_by", value: sortBy?.description)
            ]
        }
    }
}

enum Heroku {
    case requestApplePass
}

extension Heroku: Endpoint {
    var base: String {
        return "https://hopprsandbox.herokuapp.com"
    }
    
    var path: String {
        switch self {
            case .requestApplePass: return "/pass"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            case .requestApplePass: return []
        }
    }
}

