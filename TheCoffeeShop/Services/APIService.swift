//
// APIService.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

protocol APIServiceProtocol {
    func login(userName: String, phoneNumber: String, completion: @escaping (Result<LoginResponse, NetworkServiceError>) -> Void)
    func fetchProducts(completion: @escaping (Result<[Product], NetworkServiceError>) -> Void)
    func fetchFavouriteProducts(completion: @escaping (Result<Product, NetworkServiceError>) -> Void)
    func updateFavouriteProduct(productId: UUID, completion: @escaping (Result<Product, NetworkServiceError>) -> Void)
    func fetchCart(completion: @escaping (Result<Cart, NetworkServiceError>) -> Void)
    func fetchProfile(userId: UUID, completion: @escaping (Result<User, NetworkServiceError>) -> Void)
    func updateProfile(user: User, completion: @escaping(Result<User, NetworkServiceError>) -> Void)
    func createOrder(cart: Cart, completion: @escaping (Result<OrderStatusRecord, NetworkServiceError>) -> Void)
    func updateCart(cart: Cart, completion: @escaping (Result<Cart, NetworkServiceError>) -> Void)
}

class APIService {
    public let networkService: NetworkServiceProtocol
    
    static let shared: APIService = APIService()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}

extension APIService: APIServiceProtocol {
    func updateCart(cart: Cart, completion: @escaping (Result<Cart, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.cartItems.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .put)
        networkService.request(requestInfo: requestInfo, body: cart, result: completion)
    }
    
    func createOrder(cart: Cart, completion: @escaping (Result<OrderStatusRecord, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.order.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .post)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func fetchProfile(userId: UUID, completion: @escaping (Result<User, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.profile.rawValue + "/\(userId)"
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }

    func login(userName: String, phoneNumber: String, completion: @escaping (Result<LoginResponse, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.login.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .post)
        networkService.request(requestInfo: requestInfo, body: LoginRequest(userName: userName, phoneNumber: phoneNumber), result: completion)
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.products.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func fetchFavouriteProducts(completion: @escaping (Result<Product, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.favouriteProducts.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func updateFavouriteProduct(productId: UUID, completion: @escaping (Result<Product, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.profile.rawValue + "/\(productId)"
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .put)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func fetchCart(completion: @escaping (Result<Cart, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.carts.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .get)
        networkService.request(requestInfo: requestInfo, result: completion)
    }
    
    func updateProfile(user: User, completion: @escaping (Result<User, NetworkServiceError>) -> Void) {
        let urlString = APIConstants.baseURL + APIConstants.apiPath.profile.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let requestInfo = RequestInfo(urlInfo: url, httpMethod: .put)
        networkService.request(requestInfo: requestInfo, body: user, result: completion)
    }
}
