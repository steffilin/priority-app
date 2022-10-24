//
//  TaskHomeView.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/21/22.
//

import SwiftUI

struct TaskHomeView: View {
    let task: Task
    var body: some View {
        HStack {
            
            //the check box button
            Button {
                task.completed = !task.completed
                Task.printAllTasks()
            } label: {
                if task.completed == false {
                    Circle()
                        .strokeBorder(Color.accentColor, lineWidth: 1)
                        .background(Circle().fill(Color.bg_gray))
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                } else {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.accentColor)
                        .padding(.leading)
                }
            }
            
            
            
                
            
            
           
            
            ZStack {
                Rectangle()
                    .frame(width: 249, height: 49)
                    .cornerRadius(10)
                    .foregroundColor(Color.accentColor)
                Text(task.title)
                    .frame(width: 249 - 28, height: 49 - 28, alignment: .leading)
                    .font(Font.normalText)
            }
            .padding(.leading)
            .padding(.trailing)
        }
        
        
    }
}

struct TaskHomeView_Previews: PreviewProvider {
    
    static var task = Task.sampleData[0]
    static var previews: some View {
        TaskHomeView(task: task)
//            .background(Color.accentColor)
//            .previewLayout(.sizeThatFits)
    }
}
