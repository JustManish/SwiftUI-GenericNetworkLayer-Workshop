//
//  TechStackError.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 18/03/22.
//

import Foundation

protocol DescriptiveErrorType: Error, CustomStringConvertible {
    var title: String { get }
    func error() -> NSError
}

extension DescriptiveErrorType {
    
    var title: String {
        get {
            return "Error.Text".localized
        }
    }
    
    func error() -> NSError {
        return NSError(domain: _domain, code: _code, userInfo:
            [NSLocalizedDescriptionKey: self.description])
    }
}


enum TechStackError: DescriptiveErrorType, Equatable {
    
    case unknownError
    case customError(error: String)
    case invalidSelf
    case unknownStatusCode(statusCode: Int)
    case parsingError
    case jsonParametersNotGenerated
    case invalidEmailID
    case invalidAccessToken
    case noInternet
    case authorIDMissing
    case notificationDisabled
    case apiVersionNotSupported
    case playableURLNotFound
    case contentNotFound
    case dataNotFound
    case invalidURL
    
    var title: String {
        switch self {
        case .noInternet:
            return "HayHouse.Error.NoInternet.Title".localized
        case .notificationDisabled:
            return "NotificationDisabled.Error.Title".localized
        case .apiVersionNotSupported:
            return "HayHouse.Error.apiVersionNotSupported.Title".localized
        default:
            return "HayHouse.Error.UhOh".localized
        }
    }
    
    var description: String {
        switch self {
        case .unknownError:
            return "HayHouse.Error.UnknownError".localized
        case .customError(let error):
            return error
        case .invalidSelf:
            return "HayHouse.Error.InvalidSelf".localized
        case .unknownStatusCode(let statusCode):
            return String(format: "HayHouse.Error.UnknownStatusCode".localized, arguments: [statusCode])
        case .parsingError:
            return "HayHouse.Error.ParsingError".localized
        case .jsonParametersNotGenerated:
            return "JSON.Parameters.Not.Generated".localized
        case .invalidEmailID:
            return "HayHouse.Error.InvalidEmailID".localized
        case .invalidAccessToken:
            return "HayHouseSignin.Error.invalidAccessToken".localized
        case .noInternet:
            return "HayHouse.Error.NoInternet.Description".localized
        case .authorIDMissing:
            return "HayHouseSignUp.Error.authorIDMissing".localized
        case .notificationDisabled:
            return "NotificationDisabled.Error.Message".localized
        case .apiVersionNotSupported:
            return "HayHouse.Error.apiVersionNotSupported.Decription".localized
        case .playableURLNotFound:
            return "HayHouse.Error.PlayableURLNotFound.Description".localized
        case .contentNotFound:
            return "HayHouse.Error.ContentNotFound.Description".localized
        case .dataNotFound:
            return "HayHouse.Error.DataNotFound.Description".localized
        case .invalidURL:
            return "HayHouse.Error.InvalidURL".localized
        }
    }
}
