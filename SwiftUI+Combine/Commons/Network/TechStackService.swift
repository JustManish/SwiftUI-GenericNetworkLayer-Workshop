//
//  TechStackService.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation

protocol TechStackServiceProtocol: APIServiceProtocol {
	func request<T: URN>(with URN: T, completionHandler: @escaping (Result<T.Derived, TechStackError>) -> Void)
}

class TechStackService: APIService, TechStackServiceProtocol {
    
    let tokenString = ""
    
    func request<T: URN>(with URN: T,
                         completionHandler: @escaping (Result<T.Derived, TechStackError>) -> Void) {
        
        let headers = self.generateHeaders(with: tokenString)
        self.makeRequest(with: URN, headers: headers) { (result) in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                if error == .apiVersionNotSupported {
                    print("API Verssion Not supported.")
                } else {
                    completionHandler(.failure(error))
                }
            }
        }
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
