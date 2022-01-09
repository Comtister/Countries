//
//  SavedCountriesViewModel.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import RxSwift

class SavedCountriesViewModel : NetworkableViewModel{
    
    private var _loadingState : PublishSubject<Bool>
    var loadingState : Observable<Bool>{
        return _loadingState
    }
    
    private var _countriesState : PublishSubject<Void>
    var countriesState : Observable<Void>{
        return _countriesState
    }
    
    private(set) var countries = [CountryDetail]()
    
    override init() {
        self._loadingState = PublishSubject<Bool>()
        self._countriesState = PublishSubject<Void>()
    }
    
    func getDatas(){
        _loadingState.onNext(true)
        DatabaseManager.shared.getAllData(object: CountryDetail.self) { [weak self] results in
            self?.countries = results.objects(at: IndexSet(integersIn: results.startIndex..<results.endIndex))
            self?._countriesState.onNext(())
            self?._loadingState.onNext(false)
        }
       
    }
    
    func isSaved(id : String) -> Bool{
        let data = DatabaseManager.shared.getById(object: CountryDetail.self, id: id)
        return data != nil ? true : false
    }
    
}
