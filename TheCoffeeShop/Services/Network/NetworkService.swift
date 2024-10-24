//
// BaseAPIService.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

struct NetworkService {
    private let sessionManager: URLSession
    
    static func defaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 69
        
        return URLSession(configuration: configuration)
    }
    
    init(sessionManager: URLSession = defaultSession()) {
        self.sessionManager = sessionManager
    }
}

extension NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(requestInfo: RequestInfo, result: @escaping (Result<T, NetworkServiceError>) -> Void) {
        guard Reachability.shared.isConnectedToNetwork() else {
            result(.failure(NetworkServiceError.noConnection))
            return
        }
        
        sessionManager.dataTask(with: requestInfo.toURLRequest()) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                result(.failure(NetworkServiceError.unknownError))
                return
            }
            
            let statusCode = APIStatusCode(rawValue: response.statusCode) ?? .unknownError
            if statusCode == .success {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data)
                    print("Get data success: \(jsonResponse)")
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    result(.success(decodedData))
                } catch {
                    result(.failure(NetworkServiceError.decodeDataFailed))
                }
            } else {
                result(.failure(NetworkServiceError(statusCode: statusCode, data: data)))
            }
        }.resume()
    }

    func request<B: Encodable, T: Decodable>(requestInfo: RequestInfo, body: B, result: @escaping (Result<T, NetworkServiceError>) -> Void) {
        guard Reachability.shared.isConnectedToNetwork() else {
            result(.failure(NetworkServiceError.noConnection))
            return
        }
        
        var requestInfo = requestInfo
        
        if let body = try? JSONEncoder().encode(body) {
            requestInfo.body = body
        }
        
        sessionManager.dataTask(with: requestInfo.toURLRequest()) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                result(.failure(NetworkServiceError.unknownError))
                return
            }
            
            let statusCode = APIStatusCode(rawValue: response.statusCode) ?? .unknownError
            if statusCode == .success {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data)
                    print("Get data success: \(jsonResponse)")
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    result(.success(decodedData))
                } catch {
                    result(.failure(NetworkServiceError.decodeDataFailed))
                }
            } else {
                result(.failure(NetworkServiceError(statusCode: statusCode, data: data)))
            }
        }.resume()
    }
}
