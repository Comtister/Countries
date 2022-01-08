//
//  CountriesRequest.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation
import Alamofire

class CountriesRequest : NetworkRequest{
    override var baseUrl: String{
        return "https://wft-geo-db.p.rapidapi.com/v1/geo"
    }
    override var path: String{
        return "countries"
    }
    override var httpHeaders: HTTPHeaders?{
        return HTTPHeaders([HTTPHeader(name: "x-rapidapi-host", value: "wft-geo-db.p.rapidapi.com"),HTTPHeader(name: "x-rapidapi-key", value: "d8d96e5bf0msh42464b255f86c52p11f6a7jsnae88dcc1b95f")])
    }
    override var body: [String : String]?{
        return ["limit" : "10"]
    }
}
