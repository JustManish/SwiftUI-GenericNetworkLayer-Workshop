//
//
//  APIService.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation
import UIKit

protocol APIServiceProtocol {
	func makeRequest<T: URN>(with urnData: T, headers: [String : String]?, completionHandler: @escaping (Result<T.Derived, TechStackError>) -> Void)
}

class APIService: APIServiceProtocol {
    // MARK: - Public
	
    func makeRequest<T: URN>(with urnData: T,
                             headers: [String : String]? = nil,
                             completionHandler: @escaping (Result<T.Derived, TechStackError>) -> Void) {
        print("URL: \(urnData.baseURLType.baseURLString + urnData.endPoint.rawValue)")
        var urlComponents = URLComponents(string: urnData.baseURLType.baseURLString + urnData.endPoint.rawValue)!
        urlComponents.queryItems = urnData.urlQueryItems
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = urnData.method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = urnData.body
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let _self = self else {
                completionHandler(.failure(.invalidSelf))
                return
            }
            
            if let error = error {
                if error.isNetworkConnectionError {
                    completionHandler(.failure(.noInternet))
                } else {
                    completionHandler(.failure(.customError(error: error.localizedDescription)))
                }
                return
            }
            
            guard let _data = data, let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.unknownError))
                return
            }
            
            let statusCode = httpResponse.statusCode
            let headers = httpResponse.allHeaderFields as? [String: String]
            if statusCode == 200 {
                _self.process(responseData: _data,
                              responseHeaders: headers,
                              completion: completionHandler)
            } else if statusCode == 410 {
                completionHandler(.failure(.apiVersionNotSupported))
            } else if statusCode == 404 {
                completionHandler(.failure(.dataNotFound))
            } else {
                let error = _self.techStackError(statusCode, responseData: _data)
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func loadImageData(with url: URL?, completionHandler: @escaping (Result<Data, TechStackError>) -> Void) {
        
        guard let _url = url else {
            completionHandler(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: _url, cachePolicy: .returnCacheDataElseLoad)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let _self = self else {
                completionHandler(.failure(.invalidSelf))
                return
            }
            
            if let error = error {
                if error.isNetworkConnectionError {
                    completionHandler(.failure(.noInternet))
                } else {
                    completionHandler(.failure(.customError(error: error.localizedDescription)))
                }
                return
            }
            
            guard let _data = data, let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.unknownError))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {
                completionHandler(.success(_data))
            } else if statusCode == 410 {
                completionHandler(.failure(.apiVersionNotSupported))
            } else if statusCode == 404 {
                completionHandler(.failure(.dataNotFound))
            } else {
                let error = _self.techStackError(statusCode, responseData: _data)
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
	// MARK: - Private
	
    private func process<T: Decodable>(responseData: Data,
                                       responseHeaders: [String: String]?,
                                       completion: @escaping(Result<T, TechStackError>) -> Void) {
        if responseHeaders?[APIConstant.contentType.rawValue] == APIConstant.xmlHeader.rawValue {
            processXML(responseData: responseData, completion: completion)
        } else {
            print("Response Data: \(responseData)")
            processJSON(responseData: responseData, completion: completion)
        }
    }
    
    private func processJSON<T: Decodable>(responseData: Data,
                                           completion: @escaping(Result<T, TechStackError>) -> Void) {
        if let derivedModel = CodableMapper<T>.convert(responseData: responseData) {
            completion(.success(derivedModel))
        } else {
            completion(.failure(.parsingError))
        }
    }
    
    private func processXML<T: Decodable>(responseData: Data,
                                          completion: @escaping(Result<T, TechStackError>) -> Void){
        if let derivedModel = XMLMapper<T>.convert(responseData: responseData) {
            completion(.success(derivedModel))
        }  else {
            completion(.failure(.parsingError))
        }
    }
    
    private func techStackError(_ statusCode: Int, responseData: Data) -> TechStackError {
        if let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: []) as? NSDictionary,
            let errorMessage = jsonData.value(forKey: "message") as? String {
            return .customError(error: errorMessage)
        } else {
            return .unknownStatusCode(statusCode: statusCode)
        }
    }
}
