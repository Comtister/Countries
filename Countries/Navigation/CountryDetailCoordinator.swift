//
//  CountryDetailCoordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import UIKit

class CountryDetailCoordinator : NSObject , Coordinator , UINavigationControllerDelegate{
    
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
            //vc?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "starw"), style: .plain, target: vc, action: #selector(action))
            vc?.title = "Country Detail"
            return vc
        }
        
        navController.pushViewController(vc, animated: true)
        
    }
    
    func gotoWebPage(pageUrl : String){
        let webPageCoordinator = WebViewCoordinator(navController: self.navController, pageUrl: pageUrl)
        subCoordinators.append(webPageCoordinator)
        webPageCoordinator.start()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let workVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(workVC){
            return
        }
        
        if let detailCountryVC = workVC as? WebViewController{
            removeSubCoordinator(coordinator: detailCountryVC.coordinator)
        }
        
    }
    
}
