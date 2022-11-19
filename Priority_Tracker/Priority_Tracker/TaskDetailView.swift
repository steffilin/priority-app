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
    @Binding var tasks: [Task]
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentation
    @State var showHome = false
    @FocusState private var textIsFocused: Bool
    let saveAction: ()->Void

    
    var body: some View {
        ScrollView {
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
                    TextField("Title", text: $task.title)
                        .frame(width: 318.0 - 28, height: 50.0 - 26)
                        .focused($textIsFocused)
                }
                .padding(.bottom)
                
                ZStack {
                    Rectangle()
                        .frame(width: 318, height: 50)
                        .cornerRadius(10)
                        .foregroundColor(Color.bg_gray)
                    DatePicker("Due", selection: $task.due_date)
                        .frame(width: 318.0 - 28, height: 50.0 - 26)
                        .focused($textIsFocused)
                }
                .padding(.bottom)
                
                ZStack {
                    Rectangle()
                        .frame(width: 318, height: 251)
                        .cornerRadius(10)
                        .foregroundColor(Color.bg_gray)
                    VStack {
                        TextEditorWithPlaceholder(text: $task.description)
                            .focused($textIsFocused)
                            .textSelection(.enabled)
                    }
                }
                .padding(.bottom)
                
                
                Button("Save") {
                    showHome.toggle()
    //                    presentation.wrappedValue.dismiss()
    //                    ContentView.showingHome = false
                    
                }.padding()
                    .frame(width: 137.0, height: 50.0)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .font(Font.buttonText)
                    .frame(width: 318.0, height: 50.0, alignment: .leading)
                    .disabled(task.title.isEmpty)
                    .fullScreenCover(isPresented: $showHome) {
    //                        withoutAnimation {
    //                            ContentView(tasks: Task.tasks)
    //                        }
                        ContentView(tasks: $tasks) {
                            TaskStore.save(tasks: store.tasks) { result in
                                if case .failure(let error) = result {
                                    fatalError(error.localizedDescription)
                                }
                            }
                        }
                        
                    }
                    
                Spacer()
               
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
        
        .onTapGesture {
            hideKeyboard()
            textIsFocused = false
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: .constant(Task.sampleData[0]), tasks: .constant(Task.sampleData), saveAction: {})
            .environmentObject(TaskStore())
    }
}
