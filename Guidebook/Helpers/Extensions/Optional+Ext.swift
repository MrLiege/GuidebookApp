//
//  Optional+Ext.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        self ?? 0
    }
}
