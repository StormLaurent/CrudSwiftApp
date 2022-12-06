//
//  CrudSwiftAppApp.swift
//  CrudSwiftApp
//
//  Created by Armando Salcido on 04/12/22.
//

import SwiftUI


@main
struct CrudSwiftApp: App {
    

    var body: some Scene {
        WindowGroup {
           ContentView(coreDM: CoreDataManager())
               //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
