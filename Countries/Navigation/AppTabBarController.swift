//
//  AppTabBarController.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import Foundation
import UIKit

class AppTabBarController : UITabBarController{
    
    let countriesCoordinator = CountriesCoordinator(navController: UINavigationController())
    let savedCountriesCoordinator = SavedCountriesCoordinator(navController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesCoordinator.start()
        savedCountriesCoordinator.start()
        
        viewControllers = [countriesCoordinator.navController , savedCountriesCoordinator.navController]
        tabBar.backgroundColor = .gray
        tabBar.tintColor = .white
    }
    
}
