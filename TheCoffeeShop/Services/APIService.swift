//
// APIService.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

protocol APIServiceProtocol {
    func login(userName: String, phoneNumber: String, completion: @escaping (Result<User, NetworkServiceError>) -> Void)
    func fetchProducts(completion: @escaping (Result<[Product], NetworkServiceError>) -> Void)
    func fetchFavouriteProducts(completion: @escaping (Result<Product, NetworkServiceError>) -> Void)
    func updateProduct(product: Product, completion: @escaping (Result<Product, NetworkServiceError>) -> Void)
    func fetchCart(completion: @escaping (Result<Cart, NetworkServiceError>) -> Void)
    func updateProfile(user: User, completion: @escaping(Result<User, NetworkServiceError>) -> Void)
}

class APIService {
    public let networkService: NetworkServiceProtocol
    
    static let shared: APIService = APIService()
    
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
}

extension APIService: APIServiceProtocol {
    func login(userName: String, phoneNumber: String, completion: @escaping (Result<User, NetworkServiceError>) -> Void) {
        
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkServiceError>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/6b672b60-f13d-4159-b0e0-621cc9bb0e6f") else { return }
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func fetchFavouriteProducts(completion: @escaping (Result<Product, NetworkServiceError>) -> Void) {
        
    }
    
    func updateProduct(product: Product, completion: @escaping (Result<Product, NetworkServiceError>) -> Void) {
        
    }
    
    func fetchCart(completion: @escaping (Result<Cart, NetworkServiceError>) -> Void) {
        
    }
    
    func updateProfile(user: User, completion: @escaping (Result<User, NetworkServiceError>) -> Void) {
        
    }
}
