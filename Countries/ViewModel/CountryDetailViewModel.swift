//
//  CountryDetailViewModel.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import RxSwift

class CountryDetailViewModel : NetworkableViewModel{
    
    private var _loadingState : PublishSubject<Bool>
    var loadingState : Observable<Bool>{
        return _loadingState
    }
    
    private var _countriesDetailState : PublishSubject<Void>
    var countriesDetailState : Observable<Void>{
        return _countriesDetailState
    }
    
    private(set) var countryDetail : CountryDetailResponse?
    
    private(set) var id : String
    
    init(id : String){
        self._loadingState = PublishSubject<Bool>()
        self._countriesDetailState = PublishSubject<Void>()
        self.id = id
    }
    
    func getDetailData(){
        
        _loadingState.onNext(true)
        
        NetworkServiceManager.shared.sendRequest(request: CountryDetailRequest(id: id)) { [weak self] (result : Result<CountryDetailResponse,NetworkServiceError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.countryDetail = response
                    self?._loadingState.onNext(false)
                    self?._countriesDetailState.onNext(())
                case .failure(let error):
                    self?._loadingState.onNext(false)
                    self?._countriesDetailState.onError(error)
                }
            }
            
        }
        
    }
    
}
