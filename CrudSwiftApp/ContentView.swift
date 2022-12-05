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
            TextField("clv_obra", text: $clv_obra).textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
