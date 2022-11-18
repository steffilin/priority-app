//
//  TaskView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/17/22.
//

import SwiftUI

struct TaskView: View {
    

    @StateObject var task = Task(title: "", due_date: Date(), description: "")
    @State var title: String = ""
    @State var due_date: Date = Date()
    @State var description: String = ""
    @State var completed: Bool = false
    
    @Environment(\.presentationMode) var presentation
    @State var showHome = false
    @FocusState private var textIsFocused: Bool
    
    
    @EnvironmentObject var store: TaskStore
    @Binding var tasks: [Task]
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Add a Task")
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
                
                ZStack {
                    Rectangle()
                        .frame(width: 318, height: 50)
                        .cornerRadius(10)
                        .foregroundColor(Color.bg_gray)
                    DatePicker("Due", selection: $due_date)
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
                        TextEditorWithPlaceholder(text: $description)
                            .focused($textIsFocused)
                    }
                }
                
                .padding(.bottom)
                
                }
                Button("Add") {
                    
                    task.setTitle(title: title)
                    task.setDueDate(date: due_date)
                    task.setDescription(description: description)
                    tasks = Task.addTask(task: task, store: tasks)

    //                    Task.printAllTasks()
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
                    .disabled(title.isEmpty)
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


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(tasks: .constant(Task.sampleData), saveAction: {})
            .environmentObject(TaskStore())
        
    }
}

//extension View {
//    func withoutAnimation(action: @escaping () -> Void) {
//        var transaction = Transaction()
//        transaction.disablesAnimations = true
//        withTransaction(transaction) {
//            action()
//        }
//    }
//}
