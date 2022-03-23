//
//  Error+Extension.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 18/03/22.
//

import Foundation

extension Error {
    var isNetworkConnectionError: Bool {
        let networkErrors = [NSURLErrorDataNotAllowed, NSURLErrorNotConnectedToInternet]
        if _domain == NSURLErrorDomain && networkErrors.contains(_code) {
            return true
        }
        return false
    }
}

