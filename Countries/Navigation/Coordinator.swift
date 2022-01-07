//
//  Coordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject{
    
    var subCoordinators : [Coordinator] {get set}
    var navController : UINavigationController {get set}
    var storyboard : UIStoryboard {get set}
    
    func start()
    
}

extension Coordinator{
    
    func appendSubCoordinator(coordinator : Coordinator){
        subCoordinators.append(coordinator)
    }
    
    func removeSubCoordinator(coordinator : Coordinator){
        subCoordinators = subCoordinators.filter({ $0 !== coordinator })
    }
    
}
