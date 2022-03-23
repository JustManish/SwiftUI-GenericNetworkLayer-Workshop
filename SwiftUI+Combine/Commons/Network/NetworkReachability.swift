//
//  NetworkReachability.swift
//  HayHouse
//
//  Created by Santosh Karnati on 02/01/20.
//  Copyright © 2020 Hay House, Inc. All rights reserved.
//

import Foundation
import Network
/*
protocol NetworkReachabilityProtocol {
	func isReachable() -> Bool
	func isReachableOnEthernetOrWiFi() -> Bool
	func checkForReachability(listener: @escaping NetworkReachabilityManager.Listener)
	func startListening()
}

class NetworkReachability: NetworkReachabilityProtocol {
    private var listener: NetworkReachabilityManager.Listener?
	private let networkReachability = NWPathMonitor()
    
	// MARK: - Public
	
	func isReachable() -> Bool {
		return networkReachability?.isReachable ?? false
	}
	
	func isReachableOnEthernetOrWiFi() -> Bool {
		return networkReachability?.isReachableOnEthernetOrWiFi ?? false
	}
	
    func checkForReachability(listener: @escaping NetworkReachabilityManager.Listener) {
        guard let _networkReachability = networkReachability else {
            return
        }
        self.listener = listener
        _networkReachability.startListening(onUpdatePerforming: listener)
    }
    
    func startListening() {
        guard let _networkReachability = networkReachability, let _listener = listener else {
            return
        }
        _networkReachability.startListening(onUpdatePerforming: _listener)
    }
}
*/
