//
//  TasksViewModel.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import Foundation

protocol TasksViewModelProtocol: OneOfManyChooseProtocol {
    var tasks: [Task] { get set }
    
    func onAppear()
    func fetchTasks()
}

final class TasksViewModel: ObservableObject, TasksViewModelProtocol {
    typealias DataModel = Task
    @Published var choosed: DataModel?
    
    @Published var tasks: [Task] = [Task]()
    
    private var coreDataService: TaskCoreDataServiceProtocol
    private var userDefaultsService: TaskUserDefaultsProtocol
    
    init(coreDataService: TaskCoreDataServiceProtocol = CoreDataService.shared,
         userDefaultsService: TaskUserDefaultsProtocol = UserDefaultsService.shared) {
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
    }
    
    // MARK: - TasksViewModelProtocol
    
    func onAppear() {
        fetchTasks()
        fetchCurrentTask()
    }
    
    func fetchTasks() {
        tasks = coreDataService.fetchTasks()
    }
    
    func fetchCurrentTask() {
        guard let currentTaskUUID = userDefaultsService.getCurrentTaskID() else { return }
        choosed = coreDataService.findByUUID(uuid: currentTaskUUID)
    }
    
    // MARK: - OneOfManyChooseProtocol
    
    func isModelChoosed(_ model: DataModel) -> Bool {
        if choosed == model {
            return true
        }
        return false
    }
    
    func setChoosed<DataModel>(model: DataModel) {
        if let uuid = (model as! Task).id {
            userDefaultsService.setCurrentTaskID(uuid)
        }
        choosed = model as? Task
        fetchTasks()
    }
}

// MARK: - CreateTaskDelegate

extension TasksViewModel: CreateTaskDelegate {
    func create(name: String, description: String) {
        coreDataService.addTask(name: name, description: description)
        fetchTasks()
    }
}

// MARK: - TaskMenuDelegate

extension TasksViewModel: TaskMenuDelegate {
    func edit(task: Task) {
        coreDataService.updateTask(task)
    }
    
    func delete(task: Task) {
        coreDataService.deleteTask(task: task)
        fetchTasks()
    }
}
