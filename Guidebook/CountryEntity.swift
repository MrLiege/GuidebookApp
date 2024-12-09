//
//  CountryEntity.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 07.12.2024.
//

//import CoreData
//
//@objc(CountryEntity)
//public class CountryEntity: NSManagedObject {
//    @NSManaged public var id: UUID
//    @NSManaged public var nameCommon: String
//    @NSManaged public var nameOfficial: String
//    @NSManaged public var flag: String
//    @NSManaged public var region: String
//    @NSManaged public var capital: [String]
//    @NSManaged public var population: Int32
//    @NSManaged public var area: Double
//    @NSManaged public var currencies: [String: String]
//    @NSManaged public var languages: [String: String]
//    @NSManaged public var timezones: [String]
//    @NSManaged public var latlng: [Double]
//    @NSManaged public var flagsPng: String
//    @NSManaged public var flagsSvg: String
//}
//
//extension CountryEntity {
//    func toCountry() -> Country {
//        return Country(
//            id: id,
//            name: Name(common: nameCommon, official: nameOfficial),
//            flag: flag,
//            region: region,
//            capital: capital,
//            population: Int(population),
//            area: area,
//            currencies: currencies.map { (key, value) in (key, Currency(name: value, symbol: "")) }, // добавьте логику для символа
//            languages: languages,
//            timezones: timezones,
//            latlng: latlng,
//            flags: Flags(png: flagsPng, svg: flagsSvg)
//        )
//    }
//}
