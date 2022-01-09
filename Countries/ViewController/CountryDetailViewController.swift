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
    
    var barButtonItem : UIBarButtonItem!
    
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
        
        barButtonItem = UIBarButtonItem(image: UIImage(named: "starw"), style: .plain, target: self, action: #selector(action))
        barButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = barButtonItem
        
        observeViewModel()
        trigerDataFetch()
        
    }
    
    private func observeViewModel(){
        
        viewModel.countriesDetailState.subscribe(onNext : { [weak self] in
            self?.containerView.isHidden = false
            self?.countryCodeLbl.text = self?.viewModel.countryDetail?.data.code
            self?.barButtonItem.image = (self?.viewModel.isSaved(id: (self?.viewModel.id)!))! ? UIImage(named: "starb") : UIImage(named: "starw")
            self?.countryImageView.kf.indicatorType = .activity
            self?.countryImageView.kf.setImage(with : URL(string: (self?.viewModel.countryDetail?.data.flagImageUri)!) , options: [.processor(SVGImageProcessor())])
        },onError: { [weak self] error in
            self?.showNetworkErrorDialog(handler: { _ in
                self?.trigerDataFetch()
            })
        }).disposed(by: disposeBag)
        
        viewModel.loadingState.subscribe(onNext:{ [weak self] state in
            state == true ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
        
        viewModel.networkState.subscribe(onNext : { [weak self] state in
            guard state == true else {self?.showNetworkErrorDialog(handler: { _ in
                self?.trigerDataFetch()
            }) ; return}
        }).disposed(by: disposeBag)
        
        
    }
    
    private func trigerDataFetch(){
        viewModel.getDetailData()
    }
    
    @objc func action(){
        
        guard let countryDetail = self.viewModel.countryDetail?.data else {return}
       
        viewModel.changeSaveState(countryDetail: countryDetail).subscribe(onSuccess :{ [weak self] state in
            switch state{
                case .saved :
                self?.barButtonItem.image = UIImage(named: "starb")
                case .deleted :
                self?.barButtonItem.image = UIImage(named: "starw")
            }
        },onFailure: { [weak self] error in
            self?.showDatabaseErrorDialog { _ in
                self?.coordinator?.goBackward()
            }
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func gotoWebPage(_ sender : Any){
        coordinator?.gotoWebPage(pageUrl: (self.viewModel.countryDetail?.data.wikiDataId)!)
    }

}
