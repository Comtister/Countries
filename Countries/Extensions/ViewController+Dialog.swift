//
//  ViewController+Dialog.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showNetworkErrorDialog(){
        let alertController = UIAlertController(title: "ops", message: "No Internet Connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showServerErrorDialog(){
        let alertController = UIAlertController(title: "ops", message: "An Error Occurred", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
