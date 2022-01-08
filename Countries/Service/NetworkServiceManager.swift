//
//  NetworkServiceManager.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import Alamofire

class NetworkServiceManager{
    
    static let shared : NetworkServiceManager = NetworkServiceManager()
    private let session : Session
    
    private init(){
        let sessionConfig = Session.default.sessionConfiguration
        sessionConfig.timeoutIntervalForRequest = 6
        self.session = Session(configuration : sessionConfig)
    }
    
    func sendRequest<T : Codable>(request : NetworkRequest , completion : @escaping (Result<T,NetworkServiceError>) -> Void){
        
        do{
            try session.request(request: request).validate(statusCode: 200...300).response(queue: .global(qos: .userInitiated), completionHandler: { response in
                switch response.result{
                case .success(let data) :
                    guard let data = data else {completion(Result.failure(NetworkServiceError.DataNotValid)) ; return}
                    let responseModel = NetworkResponse<T>(data: data)
                    guard let object = responseModel.object else {completion(Result.failure(NetworkServiceError.DataParsingError)) ; return}
                    completion(Result.success(object))
                    
                case .failure(let error) :
                    let generalizedError = error.responseCode == nil ? NetworkServiceError.NetworkError : NetworkServiceError.ServerError
                                        completion(Result.failure(generalizedError))
                }
            })
        }catch{
            completion(Result.failure(NetworkServiceError.NetworkError))
        }
        
    }
    
}
