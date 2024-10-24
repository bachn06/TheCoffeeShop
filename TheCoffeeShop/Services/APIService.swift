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
    func updateFavouriteProduct(productId: UUID, completion: @escaping (Result<Product, NetworkServiceError>) -> Void)
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
    
    func updateFavouriteProduct(productId: UUID, completion: @escaping (Result<Product, NetworkServiceError>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/6b672b60-f13d-4159-b0e0-621cc9bb0e6f") else { return }
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .post)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func fetchCart(completion: @escaping (Result<Cart, NetworkServiceError>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/6b672b60-f13d-4159-b0e0-621cc9bb0e6f") else { return }
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func addToCart(cart: Cart, completion: @escaping (Result<Cart, NetworkServiceError>) -> Void) {
        
    }
    
    func updateProfile(user: User, completion: @escaping (Result<User, NetworkServiceError>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/6b672b60-f13d-4159-b0e0-621cc9bb0e6f") else { return }
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
}
