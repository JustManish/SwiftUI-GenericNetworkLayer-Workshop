//
//
//  APIService.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation
import Combine

protocol _APIServiceProtocol {
    func request<T: URN>(with urn: T, headers: [String : String]?) -> AnyPublisher<T.Derived, TechStackError>
}

class _APIService: _APIServiceProtocol {
    
    func request<T>(with urn: T, headers: [String : String]? = nil) -> AnyPublisher<T.Derived, TechStackError> where T : URN {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        var urlComponents = URLComponents(string: urn.baseURLType.baseURLString + urn.endPoint.rawValue)!
        urlComponents.queryItems = urn.urlQueryItems
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = urn.method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = urn.body
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { error in .customError(error: error.localizedDescription) }
            .flatMap { data, response -> AnyPublisher<T.Derived, TechStackError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .dataNotFound)
                        .eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: T.Derived.self, decoder: jsonDecoder)
                        .mapError {_ in .parsingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .unknownStatusCode(statusCode: response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
