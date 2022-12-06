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
    func save(task: TaskModel) {
      tasks.append(task)
      DispatchQueue.global().async {
        self.notificationManager.save(tasks: self.tasks)
      }
      if task.reminderEnabled {
        NotificationManager.shared.scheduleNotification(task: task)
      }
    }
    func loadTasks() {
      self.tasks = notificationManager.loadTasks()
    }
}
