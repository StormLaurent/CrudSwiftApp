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
                    coreDM.actualizarViga(clv_obra: seleccionado!)
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
                seleccionado = nil
            }
            List{
                ForEach(vigasArray,id:\.self){
                    v in
                    VStack{
                        Text(v.clv_obra ?? "")
                        Text(v.clv_viga ?? "")
                        Text(v.longitud ?? "")
                        Text(v.material ?? "")
                        Text(v.peso ?? "")
                    }
                    .onTapGesture {
                        seleccionado = v
                        clv_obra = v.clv_obra ?? ""
                        clv_viga = v.clv_viga ?? ""
                        longitud = v.longitud ?? ""
                        material = v.material ?? ""
                        peso = v.peso ?? ""
                    }
                }
                .onDelete(perform:{
                    IndexSet in
                    IndexSet.forEach({index in
                        let viga = vigasArray[index]
                        coreDM.eliminarViga(Viga: viga)
                        mostrarViga()
                    })
                })
                    
                }
            Spacer()
        }.padding()
            .onAppear(perform: {
                mostrarViga()
            })
        }
        
    
    func mostrarViga(){
        vigasArray = coreDM.leerViga()
    }
    struct ContentView_preViews: PreviewProvider {
        static var previews: some View{
            ContentView(coreDM: CoreDataManager())
        }
    }
}
