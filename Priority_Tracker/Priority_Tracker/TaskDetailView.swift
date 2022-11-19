//
//  TaskDetailView.swift
//  Priority_Tracker
//
//  Created by Steffi Lin on 11/18/22.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Binding var task: Task
    
    @State var title: String = ""
    
    @EnvironmentObject var store: TaskStore
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentation
    @State var showHome = false
    @FocusState private var textIsFocused: Bool
    let saveAction: ()->Void

    
    var body: some View {
        
        VStack {
            Text("Task Details")
                .font(Font.mainTitle)
                .multilineTextAlignment(.leading)
                .frame(width: 318.0, height: 50.0, alignment: .leading)
                .padding(.bottom)
            ZStack {
                Rectangle()
                    .frame(width: 318, height: 50)
                    .cornerRadius(10)
                    .foregroundColor(Color.bg_gray)
                TextField("Title", text: $title)
                    .frame(width: 318.0 - 28, height: 50.0 - 26)
                    .focused($textIsFocused)
            }
            .padding(.bottom)
           
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: .constant(Task.sampleData[0]), saveAction: {})
            .environmentObject(TaskStore())
    }
}
