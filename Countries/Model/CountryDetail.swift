//
//  CountryDetail.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import RealmSwift

class CountryDetail : Object , Codable{
    
    @Persisted(primaryKey: true) var wikiDataId : String = ""
    @Persisted var code : String = ""
    @Persisted var flagImageUri : String = ""
    @Persisted var name : String = ""
    
    override init(){
        super.init()
    }
    
    func copyValues() -> CountryDetail{
        let countryDetail = CountryDetail()
        countryDetail.wikiDataId = self.wikiDataId
        countryDetail.code = self.code
        countryDetail.flagImageUri = self.flagImageUri
        countryDetail.name = self.name
        return countryDetail
    }
    
    enum CodingKeys : String , CodingKey{
        case code , flagImageUri , name , wikiDataId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
        self.wikiDataId = try container.decode(String.self, forKey: .wikiDataId)
        var imageUri = try container.decode(String.self, forKey: .flagImageUri)
        //HTTP change HTTPS
        let index = imageUri.index(imageUri.startIndex, offsetBy: 4)
        imageUri.insert("s", at: index)
        self.flagImageUri = imageUri
    }
    
}
