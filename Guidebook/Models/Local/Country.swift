//
//  Country.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation

struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: Name
    let flag: String
    let region: String
    let capital: [String]
    let population: Int
    let area: Double
    let currencies: [String: Currency]
    let languages: [String: String]
    let timezones: [String]
    let latlng: [Double]
    let flags: Flags
}

// MARK: - Name
struct Name {
    let common: String
    let official: String
    
    init(common: String = "", official: String = "") {
        self.common = common
        self.official = official
    }
    
    init(from serverName: ServerName) {
        self.common = serverName.common.orEmpty
        self.official = serverName.official.orEmpty
    }
}

// MARK: - Currency
struct Currency {
    let name, symbol: String
    
    init(name: String = "", symbol: String = "") {
        self.name = name
        self.symbol = symbol
    }

    init(from serverCurrency: ServerCurrency) {
        self.name = serverCurrency.name.orEmpty
        self.symbol = serverCurrency.symbol.orEmpty
    }
}

// MARK: - Flags
struct Flags {
    let png, svg: String
    
    init(png: String = "", svg: String = "") {
        self.png = png
        self.svg = svg
    }

    init(from serverFlags: ServerFlags) {
        self.png = serverFlags.png.orEmpty
        self.svg = serverFlags.svg.orEmpty
    }
}


extension Country {
    init(serverEntity: ServerCountry) {
        self.name = serverEntity.name.map{ Name(from: $0) } ?? Name(from: ServerName.init(common: "", official: ""))
        self.flag = serverEntity.flag.orEmpty
        self.region = serverEntity.region.orEmpty
        self.capital = serverEntity.capital ?? [""]
        self.population = serverEntity.population.orZero
        self.area = serverEntity.area ?? 0.0
        self.currencies = serverEntity.currencies?.mapValues { Currency(from: $0) } ?? [:]
        self.languages = serverEntity.languages ?? [:]
        self.timezones = serverEntity.timezones ?? [""]
        self.latlng = serverEntity.latlng ?? [0.0, 0.0]
        self.flags = serverEntity.flags.map{ Flags(from: $0) } ?? Flags(from: ServerFlags.init(png: "", svg: ""))
    }
    
    static var empty: Self {
        return Country(
            name: Name(from: ServerName(common: "", official: "")),
            flag: "",
            region: "",
            capital: [""],
            population: 0,
            area: 0.0,
            currencies: [:],
            languages: [:],
            timezones: [""],
            latlng: [0.0, 0.0],
            flags: Flags(from: ServerFlags(png: "", svg: ""))
        )
    }
}

extension Country {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
