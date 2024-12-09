//
//  NameEntity+CoreDataProperties.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 08.12.2024.
//
//

import Foundation
import CoreData


extension NameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NameEntity> {
        return NSFetchRequest<NameEntity>(entityName: "NameEntity")
    }

    @NSManaged public var common: String?
    @NSManaged public var official: String?

}

extension NameEntity : Identifiable {

}
