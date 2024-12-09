//
//  GuidebookApp.swift
//  Guidebook
//
//  Created by Artyom Petrichenko on 05.12.2024.
//

import SwiftUI

@main
struct GuidebookApp: App {
    let persistenceController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
