//
//  CurrencyEntity+CoreDataProperties.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 08.12.2024.
//
//

import Foundation
import CoreData


extension CurrencyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyEntity> {
        return NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?

}

extension CurrencyEntity : Identifiable {

}
