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
    
    var id : String
    
    init(id : String , navController : UINavigationController){
        self.navController = navController
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.id = id
    }
    
    func start() {
        let vc = storyboard.instantiateViewController(identifier: "CountryDetail") { coder in
            let viewModel = CountryDetailViewModel(id: self.id)
            let vc = CountryDetailViewController(coder: coder, viewModel: viewModel, coordinator: self)
            vc?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
            vc?.title = "Country Detail"
            return vc
        }
        
        navController.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
