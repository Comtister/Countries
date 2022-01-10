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
        let navImage = UIImage(named: "backward")
        self.navController.navigationBar.backIndicatorImage = navImage
        self.navController.navigationBar.tintColor = .black
        self.navController.navigationBar.backIndicatorTransitionMaskImage = navImage
        self.navController.navigationBar.backItem?.title = ""
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func start() {
        let vc = storyboard.instantiateViewController(identifier: "SavedCountries") { coder in
            let viewModel = SavedCountriesViewModel()
            let vc = SavedCountriesViewController(coder: coder, coordinator: self, viewModel: viewModel)
            let barItem = UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 1)
            vc?.tabBarItem = barItem
            vc?.title = "Saved Countries"
            return vc
        }
        navController.pushViewController(vc, animated: true)
    }
    
    func gotoDetail(id : String){
        let detailCoordinator = CountryDetailCoordinator(id : id , navController: navController)
        appendSubCoordinator(coordinator: detailCoordinator)
        detailCoordinator.start()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let workVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(workVC){
            return
        }
        
        if let detailCountryVC = workVC as? CountryDetailViewController{
            removeSubCoordinator(coordinator: detailCountryVC.coordinator!)
        }
        
    }
    
}
