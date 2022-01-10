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
        
        let apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .lightGray
        apperance.stackedLayoutAppearance.normal.iconColor = .black
        apperance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        apperance.stackedLayoutAppearance.selected.iconColor = .white
        apperance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = apperance
        
    }
    
    
}
