//
//  CountryEntity+CoreDataProperties.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 08.12.2024.
//
//

import Foundation
import CoreData


extension CountryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryEntity> {
        return NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
    }

    @NSManaged public var area: Double
    @NSManaged public var capital: NSObject?
    @NSManaged public var flag: String?
    @NSManaged public var id: UUID?
    @NSManaged public var latlng: NSObject?
    @NSManaged public var population: Int32
    @NSManaged public var region: String?
    @NSManaged public var languages: NSObject?
    @NSManaged public var timezones: NSObject?
    @NSManaged public var name: NameEntity?
    @NSManaged public var flags: FlagsEntity?
    @NSManaged public var currencies: NSSet?

}

// MARK: Generated accessors for currencies
extension CountryEntity {

    @objc(addCurrenciesObject:)
    @NSManaged public func addToCurrencies(_ value: CurrencyEntity)

    @objc(removeCurrenciesObject:)
    @NSManaged public func removeFromCurrencies(_ value: CurrencyEntity)

    @objc(addCurrencies:)
    @NSManaged public func addToCurrencies(_ values: NSSet)

    @objc(removeCurrencies:)
    @NSManaged public func removeFromCurrencies(_ values: NSSet)

}

extension CountryEntity : Identifiable {

}

extension CountryEntity {
    func toCountry() -> Country {
        return Country(
            name: Name(common: name?.common ?? "", official: name?.official ?? ""),
            flag: flag ?? "",
            region: region ?? "",
            capital: capital as? [String] ?? [],
            population: Int(population),
            area: area,
            currencies: (currencies as? Set<CurrencyEntity>)?.reduce(into: [String: Currency]()) { result, entity in
                result[entity.name ?? ""] = Currency(name: entity.name ?? "", symbol: entity.symbol ?? "")
            } ?? [:],
            languages: languages as? [String: String] ?? [:],
            timezones: timezones as? [String] ?? [],
            latlng: latlng as? [Double] ?? [],
            flags: Flags(png: flags?.png ?? "", svg: flags?.svg ?? "")
        )
    }
}
