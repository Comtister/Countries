//
//  CountriesViewController.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import UIKit
import RxSwift

class CountriesViewController: UIViewController {

    @IBOutlet var countryCollectionView : UICollectionView!
    @IBOutlet var activityIndicator : UIActivityIndicatorView!
    
    private var viewModel : CountriesViewModel
    weak var coordinator : CountriesCoordinator?
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder , viewModel : CountriesViewModel , coordinator : CountriesCoordinator) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        observeViewModel()
        trigerDataFetch()
    }
    
    private func observeViewModel(){
        
        viewModel.countriesState.subscribe(onNext : { [weak self] in
            self?.countryCollectionView.reloadData()
        },onError: { [weak self] error in
            self?.showNetworkErrorDialog()
        }).disposed(by: disposeBag)
        
        viewModel.loadingState.subscribe(onNext:{ [weak self] state in
            state == true ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
        
        viewModel.networkState.subscribe(onNext : { [weak self] state in
            guard state == true else {self?.showNetworkErrorDialog() ; return}
        }).disposed(by: disposeBag)
        
    }
    
    private func trigerDataFetch(){
        viewModel.getCountries()
    }
    
    private func setupCollectionView(){
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        countryCollectionView.collectionViewLayout = setupCollectionViewLayout()
        countryCollectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: "CountryCell")
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


extension CountriesViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countries.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as? CountryCollectionViewCell{
            let country = viewModel.countries.data[indexPath.row]
            cell.title = country.name
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.cellForItem(at: indexPath)?.standartAnim()
        coordinator?.gotoDetail(id : viewModel.countries.data[indexPath.row].wikiDataId)
        
        
    }
    
}

