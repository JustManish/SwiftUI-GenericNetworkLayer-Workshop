//
//  EndPoint.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import Foundation

enum EndPoint {
    case fetchBreeds
    
    var rawValue: String {
        switch self {
        case .fetchBreeds:
            return "/v1/breeds"
        }
    }
}
