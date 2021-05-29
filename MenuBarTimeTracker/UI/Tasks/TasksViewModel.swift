//
//  TasksViewModel.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import Foundation

protocol TasksViewModelProtocol {
    var tasks: [Task] { get set }
    
    func onAppear()
    func fetchTasks()
}

final class TasksViewModel: ObservableObject, TasksViewModelProtocol {
    @Published var tasks: [Task] = [Task]()
    
    private var coreDataService: TaskCoreDataServiceProtocol
    
    init(coreDataService: TaskCoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
    
    func onAppear() {
        fetchTasks()
    }
    
    func fetchTasks() {
        tasks = coreDataService.fetchTasks()
    }
}

extension TasksViewModel: CreateTaskDelegate {
    func create(name: String, description: String) {
        coreDataService.addTask(name: name, description: description)
        fetchTasks()
    }
}
