//
//  CodableMapper.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation

struct CodableMapper<T: Decodable> {
    
    static func convert(responseData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: responseData)
        } catch {
            assertionFailure("Unknown server response")
            return nil
        }
    }
}
