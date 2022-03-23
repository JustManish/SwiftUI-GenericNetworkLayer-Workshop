//
//  Configuration.swift
//  HayHouse
//
//  Created by Ajay Kokcha on 30/08/19.
//  Copyright © 2019 Hay House, Inc. All rights reserved.
//

import Foundation

protocol Configuration {
    func value<T>(for key: InfoPlistKey) -> T
    static func value<T>(for key: InfoPlistKey) -> T
}

extension Configuration {
    static func value<T>(for key: InfoPlistKey) -> T {
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? T else {
            fatalError("Invalid or missing Info.plist key: \(key)")
        }
        return value
    }
    
    func value<T>(for key: InfoPlistKey) -> T {
        Self.value(for: key)
    }
}

enum InfoPlistKey: String {
    case apiBaseURL = "API_BASE_URL"
    case appCenterAppID = "APPCENTER_APP_ID"
	case appsFlyerAppId = "APPSFLYER_APP_ID"
	case appsFlyerApiKey = "APPSFLYER_API_KEY"
    case klevuCloudSearchHostURL = "KLEVU_CLOUD_SEARCH_HOST_URL"
    case klevuTicket = "KLEVU_TICKET"
    case klevuAnalyticsApiKey = "KLEVU_ANALYTICS_API_KEY"
    case klevuAnalyticsApiUrl = "KLEVU_ANALYTICS_API_URL"
}

struct BasicConfiguration: Configuration {
    
    static func appCenterAppID() -> String {
        value(for: .appCenterAppID)
    }
}
