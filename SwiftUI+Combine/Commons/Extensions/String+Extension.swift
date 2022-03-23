//
//  String+Extension.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 18/03/22.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
