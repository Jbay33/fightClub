//
//  ContentView.swift
//  pitScoutingJordan
//
//  Created by  on 11/30/22.
//

import SwiftUI
struct ContentView: View {
    @State var newTeam = ""
    @State var teamList: [Team] = [ ]
    @State var showAlert = false
    
    var body: some View {
        NavigationView(){
            VStack{
                List{
                    ForEach(teamList){
                        team in
                        NavigationLink(destination: TeamView(team: team)){
                            Text(verbatim: "\(team.number)")
                        }
                    }
                    
                }
                .navigationTitle("Teams")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("+"){
                            showAlert.toggle()
                        }
                    }
                }
                .alert("Add Team", isPresented: $showAlert) {
                    TextField("", text: $newTeam, prompt: Text("Team"))
                    Button("Accept") {
                        showAlert = false
                        
                        if let possibleNum = Int(newTeam.trimmingCharacters(in: .whitespaces)) {
                            for i in teamList {
                                if i.number == possibleNum {
                                    newTeam = ""
                                    return
                                }
                            }
                            
                            addTeam()
                            
                            saveInput()
                        }
                        
                        newTeam = ""
                    }
                }
            }.onAppear(perform: loadInput)
        }
    }
    
    func addTeam(){
        withAnimation {
            teamList.append(Team(num: Int(newTeam.trimmingCharacters(in: .whitespaces)) ?? 0))
        }
    }
    
    func saveInput() {
        let defaults = UserDefaults.standard
        
        let encoder = JSONEncoder()
        
        let data = try? encoder.encode(teamList)
        
        defaults.set(data, forKey: "teamList")
    }
    
    func loadInput() {
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: "teamList")
        {
            do {
                let decoder = JSONDecoder()
                
                teamList = try decoder.decode([Team].self, from: data)
            } catch {
                teamList = [ ]
            }
        } else {
            teamList = [ ]
        }
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
