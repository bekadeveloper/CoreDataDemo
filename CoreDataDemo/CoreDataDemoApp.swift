//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by Begzod on 29/05/21.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
