//
//  CrudSwiftAppApp.swift
//  CrudSwiftApp
//
//  Created by Armando Salcido on 04/12/22.
//

import SwiftUI


@main
struct CrudSwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           ContentView()
               .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
