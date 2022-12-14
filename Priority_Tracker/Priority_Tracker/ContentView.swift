//
//  ContentView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/16/22.
//

import SwiftUI

struct ContentView: View {
    
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
                    ForEach(Array(tasks.enumerated()), id: \.offset) { task, element in
                        TaskHomeView(task: $tasks[task], completed: tasks[task].getCompleted(), count: task) {
                            TaskStore.save(tasks: store.tasks) { result in
                                if case .failure(let error) = result {
                                    fatalError(error.localizedDescription)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    .onDelete { indexSet in
                        tasks.remove(atOffsets: indexSet)
                    
                    }
                    
                    
//                    ForEach(tasks, id: \.id) { task in
//                        TaskHomeView(task: task, completed: task.getCompleted(), count: $count) {
//                            TaskStore.save(tasks: store.tasks) { result in
//                                if case .failure(let error) = result {
//                                    fatalError(error.localizedDescription)
//                                }
//                            }
//                        }
//                        .listRowSeparator(.hidden)
//
//                    }
//                    .onDelete { indexSet in
//                        tasks.remove(atOffsets: indexSet)
//
//                    }
                    
                    
                    
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
