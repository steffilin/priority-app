//
//  ContentView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/16/22.
//

import SwiftUI

struct ContentView: View {
    
//    @State public static var showingHome: Bool = true
    
//    @Binding var showHome:Bool
    
//    let tasks: [Task]
    @Environment(\.scenePhase) private var scenePhase

    @Binding var tasks: [Task]
    @EnvironmentObject var store: TaskStore
    let saveAction: ()->Void

    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Priority Tracker")
                    .font(Font.mainTitle)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing)
                    .ignoresSafeArea(edges: .top)
                
                List {
                    
                    ForEach(tasks, id: \.id) { task in
                        TaskHomeView(task: task)
                            .listRowSeparator(.hidden)
                    }
                    
                    
                }
                .scrollContentBackground(.hidden)
           
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: TaskView(tasks: $tasks, saveAction: {}).environmentObject(store)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 56))
                            .padding(.trailing)
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  
    
    static var previews: some View {
        ContentView(tasks: .constant(Task.sampleData),  saveAction: {})
            .environmentObject(TaskStore())
    }
}
