//
//  CoreDataManager.swift
//  CrudSwiftApp
//
//  Created by Armando Salcido on 04/12/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Viga")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion,error)in
            if let error = error {
                fatalError("Core data failed to inicialited \(error.localizedDescription)") }
        })
    }
    func guardarProducto(clv_obra: Int32,clv_viga: Int32, longitud:Double, material:String,peso:Double){
        let viga = Viga(context: persistentContainer.viewContext)
        viga.clv_obra = clv_obra
        viga.clv_viga = clv_viga
        viga.longitud = longitud
        viga.material = material
        viga.peso = peso
        
        do{
            try persistentContainer.viewContext.save()
            print("Viga guardada")
        }
        catch {
            print("Failed to save error en \(error)")
        }
    }
    
}
