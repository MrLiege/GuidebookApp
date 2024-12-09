//
//  ServerCountry.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation

struct ServerCountry: Codable {
    let name: ServerName?
    let flag: String?
    let region: String?
    let capital: [String]?
    let population: Int?
    let area: Double?
    let currencies: [String: ServerCurrency]?
    let languages: [String: String]?
    let timezones: [String]?
    let latlng: [Double]?
    let flags: ServerFlags?
}

// MARK: - Name
struct ServerName: Codable {
    let common: String?
    let official: String?
}

// MARK: - Currency
struct ServerCurrency: Codable {
    let name, symbol: String?
}

struct ServerFlags: Codable {
    let png: String?
    let svg: String?
}
