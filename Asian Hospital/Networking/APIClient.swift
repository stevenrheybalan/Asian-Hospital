//
//  APIClient.swift
//  Asian Hospital
//
//  Created by HopprLab on 19/03/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case unauthorizedToken
    case activationOnProgress
    case noRecordFound
    case failedWithMessage(ErrorMessage)
    
    var localizedDescription: String {
        switch self {
            case .requestFailed: return "Request Failed"
            case .invalidData: return "Invalid Data"
            case .responseUnsuccessful: return "Response Unsuccessful"
            case .jsonParsingFailure: return "JSON Parsing Failure"
            case .jsonConversionFailure: return "JSON Conversion Failure"
            case .unauthorizedToken: return "Token is Invalid"
            case .activationOnProgress: return "Activation is on Progress"
            case .noRecordFound: return "No Record Found"
            case .failedWithMessage(let message): return message.description
        }
    }
}

protocol APIClient {
    var session: URLSession { get }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, APIError?) -> Void
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], APIError>) -> Void)
}

extension APIClient {
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    }catch {
                        completion(nil, .jsonConversionFailure)
                    }
                }else {
                    completion(nil, .invalidData)
                }
            }else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func fetchData(with request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(.invalidData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
               completion(Result.success(data))
            case 400:
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON, let errorMessage = ErrorMessage(json: json) {
                        completion(Result.failure(.failedWithMessage(errorMessage)))
                    }else {
                        completion(Result.failure(.invalidData))
                    }
                }catch {
                    completion(Result.failure(.jsonConversionFailure))
                }
            default:
                completion(Result.failure(.responseUnsuccessful))
            }
        }
        
        task.resume()
    }
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = jsonTask(with: request) { json, error in
            // At this point we are done in the background thread. So it's ok to switch to main thread.
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    }else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                
                if let value = parse(json) {
                    completion(Result.success(value))
                }else {
                    completion(Result.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
    }
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], APIError>) -> Void) {
        let task = jsonTask(with: request) { json, error in
            // At this point we are done in the background thread. So it's ok to switch to main thread.
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    }else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                
                let value = parse(json)
                
                if !value.isEmpty {
                    completion(Result.success(value))
                }else {
                    completion(Result.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
    }
    
    func fetch(with request: URLRequest, parse: @escaping ([JSON]) -> [JSONDecodable], completion: @escaping (Result<[JSONDecodable], APIError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.failure(.requestFailed))
                return
            }
            
            print("Request \(request.url!)")
            print("Status code: \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {
                        completion(Result.failure(.invalidData))
                        return
                    }
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [JSON] {
                            guard json.count > 0 else {
                                completion(Result.failure(.invalidData))
                                return
                            }
                            
                            let data = parse(json)
                            completion(Result.success(data))
                        }else {
                            completion(Result.failure(.invalidData))
                        }
                    }catch {
                        completion(Result.success([]))
                    }
                case 401:
                    completion(Result.failure(.unauthorizedToken))
                case 409:
                    completion(Result.failure(.activationOnProgress))
                case 500:
                    completion(Result.failure(.activationOnProgress))
                default:
                    completion(Result.failure(.requestFailed))
            }
        }
        
        task.resume()
    }
}
