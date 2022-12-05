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
        persistentContainer = NSPersistentContainer(name: "CrudSwiftApp")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion,error)in
            if let error = error {
                fatalError("Core data failed to inicialited \(error.localizedDescription)") }
        })
    }
    func guardarViga(clv_obra: Int32,clv_viga: Int32, longitud:Double, material:String,peso:Double){
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
    func leerViga() -> [Viga]{
        let fetchRequest : NSFetchRequest <Viga> = Viga.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    func eliminarViga(Viga:Viga){
        persistentContainer.viewContext.delete(Viga)
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            persistentContainer.viewContext.rollback()
            print("Ha ocurrido un error \(error.localizedDescription)")
        }
    }
    func actualizarViga(clv_obra: Int32,clv_viga: Int32, longitud:Double, material:String,peso:Double){
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "clViga = %@", clv_viga ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let v = datos.first
            v?.clv_obra = clv_obra
            v?.clv_viga = clv_viga
            v?.longitud = longitud
            v?.material = material
            v?.peso = peso
        }
        catch{
            print("Error en \(error)")
        }
    }
}
