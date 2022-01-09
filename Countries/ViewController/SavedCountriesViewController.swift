//
//  SavedCountriesViewController.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import UIKit
import RxSwift

class SavedCountriesViewController: UIViewController {

    @IBOutlet var savedCountryCollectionView : UICollectionView!
    
    private let viewModel : SavedCountriesViewModel
    weak var coordinator : SavedCountriesCoordinator?
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder , coordinator : SavedCountriesCoordinator , viewModel : SavedCountriesViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        observeViewModel()
        triggerDataFetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getDatas()
    }
    
    private func observeViewModel(){
        
        viewModel.countriesState.subscribe(onNext:{ [weak self] in
            self?.savedCountryCollectionView.reloadData()
        },onError: { [weak self] error in
          //Handle Error
        }).disposed(by: disposeBag)
        
    }
    
    private func triggerDataFetch(){
        viewModel.getDatas()
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
        return viewModel.countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as? CountryCollectionViewCell{
            let country = viewModel.countries[indexPath.row]
            cell.favIcon = (viewModel.isSaved(id: country.wikiDataId) ? UIImage(named: "starb") : UIImage(named: "starw"))!
            cell.title = country.name
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.standartAnim()
        coordinator?.gotoDetail(id: viewModel.countries[indexPath.row].wikiDataId)
    }
    
}
