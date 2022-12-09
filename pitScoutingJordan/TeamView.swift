//
//  TeamView.swift
//  pitScoutingJordan
//
//  Created by Milo Woodman on 12/8/22.
//

import Foundation
import SwiftUI

struct TeamView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var editmode: Bool = false
    @State var deletePopup: Bool = false
    
    var team: Team
    
    var body: some View {
        NavigationView {
            VStack {
                Text(verbatim: "gonna implode ~ \(team.number)")
                if editmode {
                    Button {
                        deletePopup = true
                    } label: {
                        Text("Delete")
                    }.buttonStyle(.borderedProminent)
                        .tint(.red)
                }
            }
        }.navigationTitle("Team " + String(team.number))
            .toolbar {
                ToolbarItem {
                    Button {
                        //dismiss()
                        editmode = !editmode
                    } label: {
                        Text(editmode ? "Save" : "Edit")
                    }.buttonStyle(.borderedProminent).tint( editmode ? .red : .blue )

                }
            }
            .navigationBarBackButtonHidden(editmode)
            .alert("Are you sure?", isPresented: $deletePopup) {
                Button {
                    deleteSelf()
                    deletePopup = false
                    dismiss()
                } label: {
                    Text("Confirm")
                }
                
                Button {
                    deletePopup = false
                } label: {
                    Text("Cancel")
                }
            }
    }

    func deleteSelf() {
        let defaults = UserDefaults.standard
        var items: [Team] = []
        
        if let data = defaults.data(forKey: "teamList")
        {
            do {
                let decoder = JSONDecoder()
                
                let preview = try decoder.decode([Team].self, from: data)
                items = preview
            } catch {
                return
            }
        } else {
            return
        }
        
        for i in 0...items.count {
            if items[i] == team {
                items.remove(at: i)
                break
            }
        }
        
        let encoder = JSONEncoder()
        
        let data = try? encoder.encode(items)
        
        defaults.set(data, forKey: "teamList")
    }
}
