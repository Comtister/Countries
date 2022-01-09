//
//  ViewController+Dialog.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showNetworkErrorDialog(handler : @escaping (UIAlertAction) -> Void){
        let alertController = UIAlertController(title: "ops", message: "No Internet Connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: handler))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showServerErrorDialog(handler : @escaping (UIAlertAction) -> Void){
        let alertController = UIAlertController(title: "ops", message: "An Error Occurred", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: handler))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showDatabaseErrorDialog(handler : @escaping (UIAlertAction) -> Void){
        let alertController = UIAlertController(title: "ops", message: "An Error Occurred", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: handler))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
