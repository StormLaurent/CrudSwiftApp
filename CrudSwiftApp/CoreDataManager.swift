//
//  CoreDataManager.swift
//  CrudSwiftApp
//
//  Created by Armando Salcido on 04/12/22.
//

import Foundation
import CoreData
import CoreText

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
    func guardarViga(clv_obra: String,clv_viga: String, longitud:String, material:String,peso:String){
        let v = Viga(context: persistentContainer.viewContext)
        v.clv_obra = clv_obra
        v.clv_viga = clv_viga
        v.longitud = longitud
        v.material = material
        v.peso = peso
        
        
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
    func leerViga(clv_viga:String)->Viga?{
        let fetchRequest: NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format:"clv = %@", clv_viga)
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }
        catch{
            print("Error al guardar en \(error)")
        }
        return nil
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
    func actualizarViga(clv_viga:Viga){
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "clViga = %@", clv_viga ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let v = datos.first
            v?.clv_obra = clv_viga.clv_obra
            v?.clv_viga = clv_viga.clv_viga
            v?.longitud = clv_viga.longitud
            v?.material = clv_viga.material
            v?.peso = clv_viga.peso
            try persistentContainer.viewContext.save()
            print("Viga guardada")
        }
        catch{
            print("Error en \(error)")
        }
    }
}
