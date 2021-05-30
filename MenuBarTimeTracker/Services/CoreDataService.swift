//
//  CoreDataService.swift
//  MenuBarTranslator
//
//  Created by Aiur on 25.04.2021.
//

import Foundation

protocol TaskTimeCoreDataServiceProtocol {
    func findByUUID(uuid: UUID) -> TaskTime?
    func fetchTaskTimes() -> [TaskTime]
    func addTaskTime(time: Date, task: Task)
    func deleteTaskTime(taskTime: TaskTime)
    func updateTaskTime(_ taskTime: TaskTime)
}

extension TaskTimeCoreDataServiceProtocol {
    func fetchTaskTimes() -> [TaskTime] {
        fetchTaskTimes()
    }
}

protocol TaskCoreDataServiceProtocol {
    func findByUUID(uuid: UUID) -> Task?
    func fetchTasks() -> [Task]
    func addTask(name: String, description: String)
    func deleteTask(task: Task)
    func updateTask(_ task: Task)
}

extension TaskCoreDataServiceProtocol {
    func fetchTasks() -> [Task] {
        fetchTasks()
    }
}

class CoreDataService {
    static let shared: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol) = CoreDataService()
    
    var coreDataHelper: CoreDataHelper = CoreDataHelper.shared
    
    private init() {}
}

// MARK: - TaskTimeCoreDataServiceProtocol

extension CoreDataService: TaskTimeCoreDataServiceProtocol {
    func updateTaskTime(_ taskTime: TaskTime) {
        coreDataHelper.update(taskTime)
    }
    
    func findByUUID(uuid: UUID) -> TaskTime? {
        let result = coreDataHelper.fetchFirst(TaskTime.self, predicate: NSPredicate(format: "id == %@", uuid as CVarArg))
        switch result {
        case .success(let taskTime):
            return taskTime
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func fetchTaskTimes() -> [TaskTime] {
        var result: Result<[TaskTime], Error>
        result = coreDataHelper.fetch(TaskTime.self)
        switch result {
        case .success(let taskTimes):
            return taskTimes
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addTaskTime(time: Date, task: Task) {
        let entity = TaskTime.entity()
        let taskTime = TaskTime(entity: entity, insertInto: coreDataHelper.context)
        taskTime.id = UUID()
        taskTime.time = time
        taskTime.task = task
        coreDataHelper.create(taskTime)
    }
    
    func deleteTaskTime(taskTime: TaskTime) {
        coreDataHelper.delete(taskTime)
    }
}

// MARK: - TaskCoreDataServiceProtocol

extension CoreDataService: TaskCoreDataServiceProtocol {
    func findByUUID(uuid: UUID) -> Task? {
        let result = coreDataHelper.fetchFirst(Task.self, predicate: NSPredicate(format: "id == %@", uuid as CVarArg))
        switch result {
        case .success(let task):
            return task
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func fetchTasks() -> [Task] {
        var result: Result<[Task], Error>
        result = coreDataHelper.fetch(Task.self)
        switch result {
        case .success(let tasks):
            return tasks
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addTask(name: String, description: String) {
        let entity = Task.entity()
        let task = Task(entity: entity, insertInto: coreDataHelper.context)
        task.id = UUID()
        task.name = name
        task.describe = description
        coreDataHelper.create(task)
    }
    
    func deleteTask(task: Task) {
        coreDataHelper.delete(task)
    }
    
    func updateTask(_ task: Task) {
        coreDataHelper.update(task)
    }
}
