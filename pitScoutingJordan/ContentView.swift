//
//  ContentView.swift
//  pitScoutingJordan
//
//  Created by  on 11/30/22.
//

import SwiftUI
struct ContentView: View {
    @State var newTeam = ""
    @State var teamList = ["484"]
    @State var showAlert = false
    @State var deleteAlert = false
    var body: some View {
        NavigationView(){
            List{
                ForEach(teamList,  id:\.self){
                    teamList in
                    Text(teamList)
                }
                .navigationTitle("Teams")
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+"){
                        showAlert.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .alert("Add Team", isPresented: $showAlert) {
                TextField("", text: $newTeam, prompt: Text("Team"))
                Button("Mibro"){
                    addTeam()
                    saveInput()
                }
            }
            .alert("Delete Team", isPresented: $deleteAlert) {
                Text("Are you sure you want to delete team ")
                Button("Delete"){
                    //delete team
                }
                Button("Cancel"){
                    //nothing
                }
            }
        }
        .onAppear(perform: loadInput)
    }
    func addTeam(){
        withAnimation{
            teamList.append("\(newTeam)")
        }
    }
    func saveInput(){
        let defaults = UserDefaults.standard
        
        defaults.set(teamList, forKey: "teamList")
    }
    func loadInput(){
        let defaults = UserDefaults.standard
        
        if let foundItems = defaults.array(forKey: "teamList") as? [String]{
            self.teamList = foundItems
        }
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
