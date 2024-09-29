//
// NetworkServiceDefinitions.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case apiVersion = "X-API-VERSION"
    case deviceID = "DEVICE-ID"
    case xAppVersion = "X-APP-VERSION"
    case xappBuild = "X-APP-BUILD"
    case platformVersion = "PLATFORM-VERSION"
    case deviceName = "DEVICE-NAME"
    case platformName = "PLATFORM-NAME"
    case sourceApp = "SOURCE-APP"
}

public enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
}

public enum APIStatusCode: Int {
    case encodeParamsFailed
    case decodeDataFailed
    case noConnection
    case unknownError
    
    case success = 200
    case badRequest = 400
    case notFound = 404
    case unauthorized = 401
    case forbidden = 403
    case internalService = 500
    case unavailable = 503
}

public struct NetworkServiceError: Error {
    let statusCode: APIStatusCode
    let data: Data?
    
    init(statusCode: APIStatusCode, data: Data? = nil) {
        self.statusCode = statusCode
        self.data = data
    }
    
    static var encodeParamsFailed = NetworkServiceError(statusCode: .encodeParamsFailed)
    static var decodeDataFailed = NetworkServiceError(statusCode: .decodeDataFailed)
    static var noConnection = NetworkServiceError(statusCode: .noConnection)
    static var unknownError = NetworkServiceError(statusCode: .unknownError)
    static var unauthorized = NetworkServiceError(statusCode: .unauthorized)
}

public typealias HTTPHeader = [String: String]

public struct RequestInfo {
    var urlInfo: URL
    let httpMethod: HTTPMethod
    var headers: HTTPHeader?
    
    init(urlInfo: URL, httpMethod: HTTPMethod, headers: HTTPHeader? = nil) {
        self.urlInfo = urlInfo
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
    mutating func appendUrlItem(name: String, value: String?) {
        urlInfo.appendQueryItem(name: name, value: value)
    }
    
    mutating func appendHeaderItem(items: HTTPHeader) {
        if headers == nil {
            headers = [:]
        }
        for (key, value) in items {
            headers?[key] = value
        }
    }
    
    func toURLRequest() -> URLRequest {
        var urlRequest = URLRequest(url: urlInfo)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
