//
//  TaskStore.swift
//  Priority_Tracker
//
//  Created by Steffi Lin on 11/12/22.
//

import Foundation

import SwiftUI

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []
    
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func setTasks(tasklist: [Task]) {
        tasks = tasklist
    }
    
    
    func addTask(task: Task) {
//        tasks.append(task)
        //need to reorder tasks
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
        
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
            .appendingPathComponent("tasks.data")
    }
    
    static func load(completion: @escaping (Result<[Task], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let tasks = try JSONDecoder().decode([Task].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tasks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    static func save(tasks: [Task], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(tasks)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(tasks.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
