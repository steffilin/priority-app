//
//  TaskView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/17/22.
//

import SwiftUI

struct TaskView: View {
//    @State private var task = Task.Data()
    @StateObject var task = Task(title: "", due_date: Date(), description: "")
    @State var title: String = ""
    @State var due_date: Date = Date()
    @State var description: String = ""
//    @State var placeholder: String = "Description"
    
    @Environment(\.presentationMode) var presentation
    @State var showHome = false
    
    var body: some View {
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
                }
                .padding(.bottom)
                
                ZStack {
                    Rectangle()
                        .frame(width: 318, height: 50)
                        .cornerRadius(10)
                        .foregroundColor(Color.bg_gray)
                    DatePicker("Due", selection: $due_date)
                        
                        .frame(width: 318.0 - 28, height: 50.0 - 26)

                }
                
                .padding(.bottom)
                
                ZStack {
                    Rectangle()
                        .frame(width: 318, height: 251)
                        .cornerRadius(10)
                        .foregroundColor(Color.bg_gray)
                    VStack {
                        TextEditorWithPlaceholder(text: $description)

                        
                            
                        
                    }
                }
                
                .padding(.bottom)
                
//                NavigationLink(destination: ContentView(tasks: Task.tasks)) {
//                    Image(systemName: "plus.circle.fill")
//                        .font(.system(size: 56))
//                        .padding(.trailing)
                }
                Button("Add") {
                    
                    
//                    let task = Task(title: title, due_date: due_date, description: description)
                    task.setTitle(title: title)
                    task.setDueDate(date: due_date)
                    task.setDescription(description: description)
                    Task.addTask(task: task)

                    Task.printAllTasks()
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
                        ContentView(tasks: Task.tasks)
                        
                    }
                    
            
                
                Spacer()
                
            
        
            }
        
    
        
    }


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
        
    }
}

extension View {
    func withoutAnimation(action: @escaping () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
}
