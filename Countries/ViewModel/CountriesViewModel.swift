//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import RxSwift

class CountriesViewModel : NetworkableViewModel{
    
    private var _loadingState : PublishSubject<Bool>
    var loadingState : Observable<Bool>{
        return _loadingState
    }
    
    private var _countriesState : PublishSubject<Void>
    var countriesState : Observable<Void>{
        return _countriesState
    }
    
    private(set) var countries = CountriesResponse()
    
    override init() {
        self._loadingState = PublishSubject<Bool>()
        self._countriesState = PublishSubject<Void>()
    }
    
    func getCountries(){
            self._loadingState.onNext(true)
        
            NetworkServiceManager.shared.sendRequest(request: CountriesRequest()) { [weak self] (result : Result<CountriesResponse , NetworkServiceError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.countries = response
                        self?._countriesState.onNext(())
                        self?._loadingState.onNext(false)
                    case .failure(let error):
                        self?._countriesState.onError(error)
                        self?._loadingState.onNext(false)
                    }
                }
            }
           
        
    }
    
    func isSaved(id : String) -> Bool{
        let data = DatabaseManager.shared.getById(object: CountryDetail.self, id: id)
        return data != nil ? true : false
    }
    
    
}
