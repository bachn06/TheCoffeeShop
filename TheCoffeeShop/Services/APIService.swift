//
// APIService.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

protocol APIServiceProtocol {
    
}

class APIService {
    public let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}

extension APIService {
    func decodeData<T: Decodable>(_ data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let response: T = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch _ {
            throw NetworkServiceError.decodeDataFailed
        }
    }
    
    func parse<T: Decodable>(dataResult: Result<Data?, NetworkServiceError>, result: @escaping (Result<T, NetworkServiceError>) -> Void) {
        switch dataResult {
        case .success(let data):
            guard let data = data, let successResponse = try? self.decodeData(data, type: T.self) else {
                let error = NetworkServiceError(statusCode: .decodeDataFailed, data: nil)
                result(.failure(error))
                return
            }
            print("Server getting success: \(successResponse)")
            result(.success(successResponse))
        case .failure(let error):
            switch error.statusCode {
            case .internalService:
                let error = NetworkServiceError(statusCode: .internalService, data: error.data)
                result(.failure(error))
            case .unavailable:
                let error = NetworkServiceError(statusCode: .unavailable, data: error.data)
                result(.failure(error))
            default:
                let error = NetworkServiceError(statusCode: error.statusCode, data: error.data)
                result(.failure(error))
            }
        }
    }
    
    func createURLString(base: String, path: String) -> String {
        let trimmedBase = base.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let trimmedPath = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        return "\(trimmedBase)/\(trimmedPath)"
    }
    
    func addParams(to urlString: String, params: [String: Any]) -> String {
        guard var urlComponents = URLComponents(string: urlString) else {
            return urlString
        }
        let queryItems: [URLQueryItem] = params.map { key, value in
            let stringValue = String(describing: value)
            return URLQueryItem(name: key, value: stringValue)
        }
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        return urlComponents.url?.absoluteString ?? urlString
    }
}
