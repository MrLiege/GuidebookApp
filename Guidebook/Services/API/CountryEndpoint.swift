//
//  CountryEndpoint.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation

enum CountryEndpoint {
    case getAllCountries
    
    var url: URL {
        switch self {
        case .getAllCountries:
            return URL(string: "https://restcountries.com/v3.1/all")!
        }
    }
}
