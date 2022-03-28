//
//  TechStackService.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation
import Combine

protocol TechStackServiceProtocol: _APIServiceProtocol {
	func request<T: URN>(with URN: T) -> AnyPublisher<T.Derived, TechStackError>
}

class TechStackService: _APIService, TechStackServiceProtocol {
    
    let tokenString = ""
    
    func request<T>(with URN: T) -> AnyPublisher<T.Derived, TechStackError> where T : URN {
        let headers = self.generateHeaders(with: tokenString)
        return self.request(with: URN, headers: headers)
    }
    
	// MARK: - Private
	
    private func generateHeaders(with tokenString: String) -> [String: String] {
        let headers: [String: String] =  [APIConstant.authorization.rawValue : "Bearer \(tokenString)",
            APIConstant.contentType.rawValue: APIConstant.contentTypeJson.rawValue,
            APIConstant.acceptEncoding.rawValue: APIConstant.gzip.rawValue,
            APIConstant.clientVersion.rawValue : APIConstant.currentClientVersion.rawValue,
            APIConstant.platformKey.rawValue : APIConstant.playformValue.rawValue ]
        return headers
    }
}
