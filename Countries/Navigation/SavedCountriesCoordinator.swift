//
//  SavedCountriesCoordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import Foundation
import UIKit

class SavedCountriesCoordinator : Coordinator{
    
    var subCoordinators: [Coordinator] = []
    var navController : UINavigationController
    var storyboard: UIStoryboard
    
    init(navController : UINavigationController){
        self.navController = navController
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func start() {
        let vc = storyboard.instantiateViewController(identifier: "SavedCountries") { coder in
            let vc = SavedCountriesViewController(coder: coder)
            let barItem = UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 1)
            vc?.tabBarItem = barItem
            vc?.title = "Saved Countries"
            return vc
        }
        navController.pushViewController(vc, animated: true)
    }
    
}
