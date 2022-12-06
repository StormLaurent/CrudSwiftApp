//
//  ContentView.swift
//  CrudSwiftApp
//
//  Created by Armando Salcido on 05/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    let coreDM: CoreDataManager
    @State var clv_obra = ""
    @State var clv_viga = ""
    @State var longitud = ""
    @State var material = ""
    @State var peso = ""
    @State var seleccionado:Viga?
    @State var vigasArray = [Viga]()
    
    var body: some View{
        VStack{
            TextField("Clave Obra", text: $clv_obra).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Clave Viga", text: $clv_viga).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Longitud", text:$longitud).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Material", text:$material).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Peso", text:$peso).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                if(seleccionado != nil){
                    seleccionado?.clv_obra = clv_obra
                    seleccionado?.clv_viga = clv_viga
                    seleccionado?.longitud = longitud
                    seleccionado?.material = material
                    seleccionado?.peso = peso
                    coreDM.actualizarViga(clv_viga: seleccionado!)
                }
                else {
                    coreDM.guardarViga(clv_obra:clv_obra,clv_viga: clv_viga,longitud: longitud,material:material,peso: peso)
                    
                }
                mostrarViga()
                clv_obra = ""
                clv_viga = ""
                longitud = ""
                material = ""
                peso = ""
                
            }
        }
        
    }
    func mostrarViga(){
        vigasArray = coreDM.leerViga()
    }
    
}
