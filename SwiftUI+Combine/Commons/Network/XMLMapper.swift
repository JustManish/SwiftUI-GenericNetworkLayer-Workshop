//
//  XMLMapper.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation


struct XMLMapper<T: Decodable> {
    
    static func convert(responseData: Data) -> T? {
        return String(decoding: responseData, as: UTF8.self) as? T
    }
}
