//
//  TaskView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/17/22.
//

import SwiftUI

struct TaskView: View {
    @State private var task = Task.Data()
    @State var title: String = ""
    @State var due_date: Date = Date()
    @State var description: String = ""
//    @State var placeholder: String = "Description"
    
    var body: some View {
        
//        ContentView(showingHome: false)
        
        NavigationView {
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
    //                    TextField("Description", text: $description, axis: .vertical)
    //                        .frame(width: 318.0 - 28, height: 251.0 - 28, alignment: .top)
                        TextEditorWithPlaceholder(text: $description)

                        
                            
                        
                    }
                }
                
                .padding(.bottom)
                
               
                Button("Add") {
                    
                    let task = Task(title: title, due_date: due_date, description: description)
                    Task.addTask(task: task)

                    Task.printAllTasks()
                    
//                    ContentView.showingHome = false
                    
                }.padding()
                    .frame(width: 137.0, height: 50.0)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .font(Font.buttonText)
                    .frame(width: 318.0, height: 50.0, alignment: .leading)
                    .disabled(title.isEmpty)
            
                
                Spacer()
                
            }
        }
        
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
        
    }
}
