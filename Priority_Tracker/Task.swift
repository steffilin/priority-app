//
//  Task.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/18/22.
//

import Foundation


class Task : Identifiable, Codable {
    
    var title: String
    var due_date: Date
    var description: String
    var completed: Bool = false
    
    //    static var isEmpty: Bool = true
    
    static var tasks: Array<Task> = []
    
    //    static var numTasks: Int = 0
    
    init(title: String, due_date: Date, description: String) {
        self.title = title
        self.due_date = due_date
        self.description = description
    }
    
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func printTask() {
        print(self.title)
        print(self.due_date)
        print(self.description)
    }
    
    class func getTasks() -> Array<Task> {
        return tasks
    }
    
    class func addTask(task: Task) {
        tasks.append(task)
        //        isEmpty = false
        //        numTasks += 1
        //sort the tasks based on priority
        //update the home page with the task in it
    }
    
    class func getTask(task: Task) {
        //
    }
    
    class func printAllTasks() {
        //        let vals = tasks.values
        for t in tasks {
            t.printTask()
        }
    }
    
    class func getNumTasks() -> Int{
        return tasks.count
    }
    
    class func empty() -> Bool {
        return tasks.isEmpty
    }
    
    
}
    
    
    extension Task {
        static let sampleData: [Task] =
        [
            Task(title: "task 1", due_date: Date(), description: "my first task"),
            Task(title: "task 2", due_date: Date(), description: "my second task"),
            Task(title: "task 3", due_date: Date(), description: "my third task")
            
        ]
        
    }

