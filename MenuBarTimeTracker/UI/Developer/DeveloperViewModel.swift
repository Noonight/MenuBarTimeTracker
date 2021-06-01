//
//  DeveloperViewModel.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 01.06.2021.
//

import Foundation
import Combine

protocol DeveloperViewModelProtocol: OneOfManyChooseProtocol {
    var tasks: [Task] { get set }
    var intervals: [TaskTime] { get set }
    
    var filterTasksByName: String { get set }
    
    var sortIntervalsBy: TaskTimeSortOptions { get set }
    var filterIntervalsByTask: Task? { get set }
    
    func onAppear()
    func fetchTasks()
    func fetchIntervals()
}

final class DeveloperViewModel: ObservableObject, DeveloperViewModelProtocol {
    var choosed: Task?
    
    typealias DataModel = Task
    
    @Published var tasks: [Task] = [Task]() {
        didSet {
            print(tasks)
        }
    }
    @Published var intervals: [TaskTime] = [TaskTime]() {
        didSet {
            print(intervals)
        }
    }
    
    @Published var filterTasksByName: String = ""
    
    @Published var sortIntervalsBy: TaskTimeSortOptions = .newer
    @Published var filterIntervalsByTask: Task?
    
    private var coreDataService: (TaskCoreDataServiceProtocol & TaskTimeCoreDataServiceProtocol)
    private var userDefaultsService: TaskUserDefaultsProtocol
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol) = CoreDataService.shared,
         userDefaultsService: TaskUserDefaultsProtocol = UserDefaultsService.shared) {
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
        
        $filterTasksByName
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.fetchTasks()
            }
            .store(in: &cancellableSet)
        
        $sortIntervalsBy
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.fetchIntervals()
            }
            .store(in: &cancellableSet)
        
        $filterIntervalsByTask
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.fetchIntervals()
            }
            .store(in: &cancellableSet)
    }
    
    private func updateUI() {
        fetchTasks()
        fetchIntervals()
    }
    
    // MARK: - DeveloperViewModelProtocol
    
    func onAppear() {
        updateUI()
    }
    
    func fetchTasks() {
        if filterTasksByName.count > 0 {
            tasks = coreDataService.fetchTasks(filterByName: filterTasksByName)
            return
        }
        tasks = coreDataService.fetchTasks(filterByName: nil)
    }
    
    func fetchIntervals() {
        intervals = coreDataService.fetchTaskTimes(sortBy: sortIntervalsBy, filterByTask: filterIntervalsByTask)
    }
    
    // MARK: - OneOfManyChooseProtocol
    
    func isModelChoosed(_ model: DataModel) -> Bool {
        if filterIntervalsByTask == model {
            return true
        }
        return false
    }
    
    func setChoosed<DataModel>(model: DataModel) {
        if let uuid = (model as! Task).id {
            userDefaultsService.setCurrentTaskID(uuid)
        }
        filterIntervalsByTask = model as? Task
        fetchTasks()
    }
}

// MARK: - CreateTaskDelegate

extension DeveloperViewModel: CreateTaskDelegate {
    func create(name: String, description: String) {
        coreDataService.addTask(name: name, description: description)
        fetchTasks()
    }
}

// MARK: - TaskMenuDelegate

extension DeveloperViewModel: TaskMenuDelegate {
    func edit(task: Task) {
        coreDataService.updateTask(task)
    }
    
    func delete(task: Task) {
        coreDataService.deleteTask(task: task)
        fetchTasks()
    }
}
