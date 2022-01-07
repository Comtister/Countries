//
//  CountriesCoordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import Foundation
import UIKit

class CountriesCoordinator : Coordinator{

    var subCoordinators: [Coordinator] = []
    var navController : UINavigationController
    var storyboard: UIStoryboard
    
    init(navController : UINavigationController){
        self.navController = navController
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func start() {
        
        let vc = storyboard.instantiateViewController(identifier: "Countries") { coder in
            let vc = CountriesViewController(coder: coder)
            vc?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
            vc?.title = "Countries"
            return vc
        }
        navController.pushViewController(vc, animated: true)
    }
    
}
