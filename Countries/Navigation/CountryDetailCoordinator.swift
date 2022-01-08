//
//  CountryDetailCoordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import UIKit

class CountryDetailCoordinator : Coordinator{
    
    var subCoordinators: [Coordinator] = []
    
    var navController: UINavigationController
    
    var storyboard: UIStoryboard
    
    init(navController : UINavigationController){
        self.navController = navController
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func start() {
        let vc = storyboard.instantiateViewController(identifier: "CountryDetail") { coder in
            let vc = CountryDetailViewController(coder: coder)
            vc?.coordinator = self
            vc?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
            vc?.title = "Country Detail"
            return vc
        }
        
        navController.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
