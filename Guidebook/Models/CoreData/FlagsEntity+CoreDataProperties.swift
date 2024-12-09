//
//  FlagsEntity+CoreDataProperties.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 08.12.2024.
//
//

import Foundation
import CoreData


extension FlagsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlagsEntity> {
        return NSFetchRequest<FlagsEntity>(entityName: "FlagsEntity")
    }

    @NSManaged public var png: String?
    @NSManaged public var svg: String?

}

extension FlagsEntity : Identifiable {

}
