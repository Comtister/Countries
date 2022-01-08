//
//  NetworkRequest.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import Alamofire

class NetworkRequest{
    
    var baseUrl : String{
        return ""
    }
    
    var path : String{
        return ""
    }
    
    var body : [String : String]?{
        return nil
    }
    
    var httpMethod : HTTPMethod{
        return .get
    }

    var encoder : URLEncodedFormParameterEncoder{
        return URLEncodedFormParameterEncoder.default
    }
    
    var httpHeaders : HTTPHeaders?{
        return nil
    }
    
    func getRequestUrl() -> URLConvertible?{
        var requestUrl = URL(string: baseUrl)
        requestUrl?.appendPathComponent(path)
        return requestUrl
    }
    
}
