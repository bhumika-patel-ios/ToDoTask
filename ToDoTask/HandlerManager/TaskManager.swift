//
//  TaskManager.swift
//  ToDoTask
//
//  Created by Bhumika Patel on 06/12/22.
//

import Foundation

class TaskManager: ObservableObject{
    static let shared = TaskManager()
    
    let notificationManager = TaskNotificationManager()
    
    @Published var tasks: [TaskModel] = []

    init(){
        loadTasks()
    }
    func loadTasks() {
      self.tasks = notificationManager.loadTasks()
    }
}
