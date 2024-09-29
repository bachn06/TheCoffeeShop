//
// NetworkServiceProtocol.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

protocol NetworkServiceProtocol {
    func request<T>(requestInfo: RequestInfo,params: T, result: @escaping (Result<Data?, NetworkServiceError>) -> Void) where T: Encodable
    func request(requestInfo: RequestInfo, params: [String: Any]?, result: @escaping (Result<Data?, NetworkServiceError>) -> Void)
}
