//
//  Priority_TrackerApp.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/16/22.
//

import SwiftUI

@main
struct Priority_TrackerApp: App {
    
    @StateObject private var store = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(tasks: $store.tasks) {
                TaskStore.save(tasks: store.tasks) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(store)
                .onAppear {
                    TaskStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let tasks):
                            store.tasks = tasks
                        }
                    }
                }
        }
        
    }
    
    
    
    
    
    
    
    
}
