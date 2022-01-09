//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 7.01.2022.
//

import UIKit
import RxSwift
import Kingfisher

class CountryDetailViewController: UIViewController {

    @IBOutlet var countryImageView : UIImageView!
    @IBOutlet var countryCodeLbl : UILabel!
    @IBOutlet var containerView : UIView!
    @IBOutlet var activityIndicator : UIActivityIndicatorView!
    
    private var viewModel : CountryDetailViewModel
    weak var coordinator : CountryDetailCoordinator?
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder , viewModel : CountryDetailViewModel , coordinator : CountryDetailCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
        trigerDataFetch()
        
    }
    
    private func observeViewModel(){
        
        viewModel.countriesDetailState.subscribe(onNext : { [weak self] in
            self?.containerView.isHidden = false
            self?.countryCodeLbl.text = self?.viewModel.countryDetail?.data.code
            self?.countryImageView.kf.indicatorType = .activity
            print(self?.viewModel.countryDetail?.data.flagImageUri)
            self?.countryImageView.kf.setImage(with : URL(string: "\(self?.viewModel.countryDetail?.data.flagImageUri)") , options: [.processor(SVGImageProcessor())])
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
        viewModel.getDetailData()
    }

}
