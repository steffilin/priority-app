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
    
    let tasks: [Task]
//    ForEach(tasks, id: \.id) {task in
//        @EnvironmentObject var task: Task
//    }

    
    
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
                    NavigationLink(destination: TaskView()) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 56))
                            .padding(.trailing)
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    .padding()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tasks: Task.tasks)
    }
}
