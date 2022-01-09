//
//  NetworkableViewModel.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import RxSwift

class NetworkableViewModel{
    
    private var _networkState : PublishSubject<Bool>
    
    final var networkState : Observable<Bool>{
        return _networkState
    }
    
    init(){
        self._networkState = PublishSubject<Bool>()
        listenNetworkStatus()
    }
    
    private func listenNetworkStatus(){
        NotificationCenter.default.addObserver(forName: .NetworkStateNotification, object: nil, queue: nil) { notification in
            guard let networkInfo = notification.userInfo as? [String : Bool] else {return}
            self._networkState.onNext(networkInfo["state"]!)
        }
    }
    
}
