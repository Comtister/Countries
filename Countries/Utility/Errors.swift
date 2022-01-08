//
//  Errors.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import Foundation

enum NetworkServiceError : Error{
    case NetworkError , ServerError , DataNotValid , DataParsingError
}
