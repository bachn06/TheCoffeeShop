//
// NetworkServiceProtocol.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(requestInfo: RequestInfo, result: @escaping (Result<T, NetworkServiceError>) -> Void)
    func request<B: Encodable, T: Decodable>(requestInfo: RequestInfo, body: B, result: @escaping (Result<T, NetworkServiceError>) -> Void)
}
