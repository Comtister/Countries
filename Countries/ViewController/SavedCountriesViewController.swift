//
//  SavedCountriesViewController.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import UIKit

class SavedCountriesViewController: UIViewController {

    @IBOutlet var savedCountryCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
    private func setupCollectionView(){
        savedCountryCollectionView.delegate = self
        savedCountryCollectionView.dataSource = self
        savedCountryCollectionView.collectionViewLayout = setupCollectionViewLayout()
        savedCountryCollectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: "CountryCell")
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width - 50, height: 50)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }
    
}


extension SavedCountriesViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as? CountryCollectionViewCell{
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.standartAnim()
    }
    
}
