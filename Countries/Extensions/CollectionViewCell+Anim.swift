//
//  CollectionViewCell+Anim.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import UIKit

extension UICollectionViewCell{
    
    func standartAnim(){
        let firstHalf = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
                    self.alpha = 0.5
                }
                let secondHalf = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
                    self.alpha = 1.0
                }
                firstHalf.addCompletion { (position) in
                    secondHalf.startAnimation()
                }
                firstHalf.startAnimation()
    }
    
}
