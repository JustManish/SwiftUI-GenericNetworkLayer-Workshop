//
//  URN.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum QueryParamKey: String {
    case active
    case quiz
    case random
}


protocol URN {
    associatedtype Derived: Decodable
    var endPoint: EndPoint { get }
    var baseURLType: BaseURLType { get }
    var queryPath: String? { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var body: Data? { get }
    var urlQueryItems: [URLQueryItem] { get }
}

extension URN {
    
    var queryPath: String? {
        return nil
    }
    
    var urlQueryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        if let parameters = parameters {
            for eachQueryParam in parameters {
                queryItems.append(URLQueryItem(name: eachQueryParam.key, value: eachQueryParam.value))
            }
        }
        return queryItems
    }
}

protocol TechStackURN: URN {}

extension TechStackURN {
    
    var baseURLType: BaseURLType {
        return .techStack
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: String]? {
        return nil
    }
}

struct CatsBreedURN: TechStackURN {
    
    typealias Derived = [Breed]
    var endPoint: EndPoint = .fetchBreeds
    var method: HTTPMethod = .get
    var queryPath: String? = "limit=9"
}
