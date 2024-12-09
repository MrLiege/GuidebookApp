//
//  Gradient+Ext.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 06.12.2024.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static func skyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.white, Color(.systemBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    static func darkSkyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.black, Color(.systemBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    static func dimSkyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.pink, Color(.systemBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    static func saladGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color(.systemIndigo), Color(.systemMint)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    static func mintGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color(.systemTeal), Color(.systemMint)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}
