//
//  TaskHomeView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/21/22.
//

import SwiftUI

struct TaskHomeView: View {
    @Binding var task: Task

    @EnvironmentObject var store: TaskStore
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentation
    @State var showDetail = false
    @State var completed: Bool
    let count: Int
    let saveAction: ()->Void
    
    
    var body: some View {
        
        HStack {

            
            Button (action: {
//                task.changeCompletion()
                completed.toggle()
                task.changeCompletion()
                //write a switchcheck swift class in a different file??? call the func here

//                Task.printAllTasks()
            }) {
                if completed {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.accentColor)
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                } else {
                    Circle()
                        .strokeBorder(Color.accentColor, lineWidth: 2)
                        .background(Circle().fill(Color.bg_gray))
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            
           
            
            ZStack {
                Button {
                    showDetail.toggle()
                } label: {
                    Rectangle()
                        .frame(width: 249, height: 49)
                }
                .frame(width: 249, height: 49)
                .background(Color.solid_accent)
                .cornerRadius(10)
                .opacity(task.calculateOpacity(count: count))
                .buttonStyle(BorderlessButtonStyle())
                .fullScreenCover(isPresented: $showDetail) {
                    TaskDetailView(task: $task, tasks: $store.tasks) {
                        TaskStore.save(tasks: store.tasks) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }

                }
                

                Text(task.title)
                    .frame(width: 249 - 28, height: 49 - 28, alignment: .leading)
                    .font(Font.normalText)
            }
            .padding(.leading)
            .padding(.trailing)
            
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        
    }
}

struct TaskHomeView_Previews: PreviewProvider {

    static var task = Task.sampleData[0]
    var completed = task.completed
    static var previews: some View {
        TaskHomeView(task: .constant(Task.sampleData[0]), completed: false, count: 0, saveAction: {})
            .environmentObject(TaskStore())
//            .background(Color.accentColor)
//            .previewLayout(.sizeThatFits)
    }
}
