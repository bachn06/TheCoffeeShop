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
    func request<T>(requestInfo: RequestInfo, params: T, result: @escaping (Result<Data?, NetworkServiceError>) -> Void) where T : Encodable {
        guard Reachability.shared.isConnectedToNetwork() else {
            result(.failure(NetworkServiceError.noConnection))
            return
        }
        
        sessionManager.dataTask(with: requestInfo.toURLRequest()) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                result(.failure(NetworkServiceError.unknownError))
                return
            }
            let statusCode = APIStatusCode(rawValue: response.statusCode) ?? .unknownError
            if statusCode == .success {
                result(.success(data))
            } else {
                result(.failure(NetworkServiceError(statusCode: statusCode, data: data)))
            }
        }
    }
    
    func request(requestInfo: RequestInfo, params: [String : Any]?, result: @escaping (Result<Data?, NetworkServiceError>) -> Void) {
        guard Reachability.shared.isConnectedToNetwork() else {
            result(.failure(NetworkServiceError.noConnection))
            return
        }
        
        sessionManager.dataTask(with: requestInfo.toURLRequest()) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                result(.failure(NetworkServiceError.unknownError))
                return
            }
            let statusCode = APIStatusCode(rawValue: response.statusCode) ?? .unknownError
            if statusCode == .success {
                result(.success(data))
            } else {
                result(.failure(NetworkServiceError(statusCode: statusCode, data: data)))
            }
        }
    }
}
