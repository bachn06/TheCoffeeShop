//
// URLExtension.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

extension URL {
    mutating func appendQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return
        }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        let parameterExists = queryItems.contains { $0.name == name }
        if !parameterExists {
            let queryItem = URLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
            urlComponents.queryItems = queryItems
            self = urlComponents.url!
        }
    }
}
