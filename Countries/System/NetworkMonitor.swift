//
//  NetworkMonitor.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import Network

class NetworkMonitor{
    
    static let networkMonitor = NetworkMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    let monitor : NWPathMonitor
    
    var isConnected : Bool{
        get{
            if monitor.currentPath.status == .satisfied{
                return true
            }else{
                return false
            }
        }
    }
    
    private init(){
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            let networkStatusNotification = Notification(name: Notification.Name.NetworkStateNotification, object: nil, userInfo: ["state" : self?.isConnected as Any])
            NotificationCenter.default.post(networkStatusNotification)
        }
    }
    
    func stopMonitoring(){
        monitor.cancel()
    }
    
}
