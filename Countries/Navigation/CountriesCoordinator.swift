//
//  CountriesCoordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import Foundation
import UIKit

class CountriesCoordinator : NSObject, Coordinator , UINavigationControllerDelegate{

    var subCoordinators: [Coordinator] = []
    var navController : UINavigationController
    var storyboard: UIStoryboard
    
    init(navController : UINavigationController){
        self.navController = navController
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func start() {
        navController.delegate = self
        let vc = storyboard.instantiateViewController(identifier: "Countries") { coder in
            let vc = CountriesViewController(coder: coder)
            vc?.coordinator = self
            vc?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
            vc?.title = "Countries"
            return vc
        }
        navController.pushViewController(vc, animated: true)
    }
    
    func gotoDetail(){
        let detailCoordinator = CountryDetailCoordinator(navController: navController)
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
