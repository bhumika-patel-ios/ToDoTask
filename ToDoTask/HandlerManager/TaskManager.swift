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
    func addNewTask(_ taskName: String,_ status: String, _ reminder: Reminder?) {
    if let reminder = reminder {
        save(task: TaskModel(name: taskName, status: status, reminderEnabled: true, reminder: reminder))
    } else {
        save(task: TaskModel(name: taskName, status: status, reminderEnabled: false, reminder: Reminder()))
    }
  }
    func removeData(at index: IndexSet) {
        tasks.remove(atOffsets: index)
        
    }
    func remove(task: TaskModel) {
      tasks.removeAll {
        $0.id == task.id
      }
      DispatchQueue.global().async {
        self.notificationManager.save(tasks: self.tasks)
      }
      if task.reminderEnabled {
        NotificationManager.shared.removeScheduledNotification(task: task)
      }
    }
}
