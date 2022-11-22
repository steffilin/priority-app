//
//  Task.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/18/22.
//

import Foundation


class Task : Identifiable, ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case title
        case due_date
        case description
        case completed
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        due_date = try container.decode(Date.self, forKey: .due_date)
        description = try container.decode(String.self, forKey: .description)
        completed = try container.decode(Bool.self, forKey: .completed)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(due_date, forKey: .due_date)
        try container.encode(description, forKey: .description)
        try container.encode(completed, forKey: .completed)
    }
    
    @Published var title: String
    @Published var due_date: Date
    @Published var description: String
    @Published var completed: Bool
    
    
    //    static var isEmpty: Bool = true
    
//    static var tasks: Array<Task> = []
    
    //    static var numTasks: Int = 0
    
    init(title: String, due_date: Date, description: String) {
        self.title = title
        self.due_date = due_date
        self.description = description
        self.completed = false
    }
    
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setDueDate(date: Date) {
        self.due_date = date
    }
    
    func setDescription(description: String) {
        self.description = description
    }
    
    
    func editTask(title: String, due_date: Date, description: String) {
        setTitle(title: title)
        setDueDate(date: due_date)
        setDescription(description: description)
    }
    
    func calculateOpacity(count: Int) -> Double {
        var opac = 1 - 0.1 * Double(count + 1)
        if opac <= 0 {
            opac = 0.1
        }
        return opac
    }


    
    func getCompleted() -> Bool {
        return self.completed
    }
    
    func changeCompletion() {
        self.completed.toggle()
    }
    
    func printTask() {
        print(self.title)
        print(self.due_date)
        print(self.description)
        print(self.completed)
    }
    

    
//    class func getTasks() -> Array<Task> {
//        return tasks
//    }
    
//    class func addTask(task: Task) {
////        tasks.append(task)
//        //need to reorder tasks
//
//        if tasks.isEmpty {
//            tasks.append(task)
//        } else {
//            for i in stride(from: tasks.count - 1, through: 0, by: -1) {
//                if task.due_date > tasks[i].due_date {
//                    tasks.insert(task, at: i + 1)
//                    break
//                } else if i == 0 {
//                    tasks.insert(task, at: 0)
//                }
//            }
//        }
//
//    }
    
    class func addTask(task: Task, store: [Task]) -> [Task] {
//        tasks.append(task)
        //need to reorder tasks
        var tasks = store
        if tasks.isEmpty {
            tasks.append(task)
        } else {
            for i in stride(from: tasks.count - 1, through: 0, by: -1) {
                if task.due_date > tasks[i].due_date {
                    tasks.insert(task, at: i + 1)
                    break
                } else if i == 0 {
                    tasks.insert(task, at: 0)
                }
            }
        }
//        store.setTasks(tasklist: tasks)
        return tasks
        
    }
    
    class func getTask(task: Task) {
        //
    }
    
//    class func printAllTasks() {
//        //        let vals = tasks.values
//        for t in tasks {
//            t.printTask()
//        }
//    }
//
//    class func getNumTasks() -> Int{
//        return tasks.count
//    }
//
//    class func empty() -> Bool {
//        return tasks.isEmpty
//    }
    
    
//    struct Data {
//        var title: String = ""
//        var due_date: Date = Date()
//        var description: String = ""
//        var completed: Bool = false
//        
//    }
//    
//    var data: Data {
//        Data(title: title, due_date: due_date, description: description)
//    }
    
    
    
    
}
    
    
    extension Task {
        static let sampleData: [Task] =
        [
            Task(title: "task 1", due_date: Date(), description: "my first task"),
            Task(title: "task 2", due_date: Date(), description: "my second task"),
            Task(title: "task 3", due_date: Date(), description: "my third task")
            
        ]
        
    }

