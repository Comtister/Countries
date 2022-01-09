//
//  WebViewCoordinator.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import UIKit

class WebViewCoordinator : Coordinator{
    
    var subCoordinators: [Coordinator] = []
    
    var navController: UINavigationController
    
    var storyboard: UIStoryboard
    var pageUrl : String
    
    init(navController : UINavigationController , pageUrl : String){
        self.navController = navController
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.pageUrl = pageUrl
    }
    
    func start() {
        let vc = storyboard.instantiateViewController(identifier: "WebView") { coder in
            return WebViewController(coder: coder, coordinator: self, pageUrl: self.pageUrl)
        }
        navController.pushViewController(vc, animated: true)
    }
    
    
    
    
}
