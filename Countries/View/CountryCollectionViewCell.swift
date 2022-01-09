//
//  CountryCollectionViewCell.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    private var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var title : String {
        get{
            return label.text ?? ""
        }set{
            label.text = newValue
        }
    }
    
    private var favIconView : UIImageView = {
        let favIconView = UIImageView()
        favIconView.translatesAutoresizingMaskIntoConstraints = false
        favIconView.image = UIImage(named: "starw")
        return favIconView
    }()
    var favIcon : UIImage{
        get{
            return favIconView.image ?? UIImage()
        }
        set{
            favIconView.image = newValue
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(favIconView)
        favIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        favIconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        favIconView.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
        favIconView.widthAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
