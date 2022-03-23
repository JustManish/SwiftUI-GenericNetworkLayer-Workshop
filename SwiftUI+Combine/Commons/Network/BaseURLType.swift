//
//  BaseURLType.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//
import Foundation

enum BaseURLType: Configuration {
    case techStack
    
    var baseURLString: String {
        
        switch self {
        case .techStack:
            return "https://api.thecatapi.com"
        }
    }
}
