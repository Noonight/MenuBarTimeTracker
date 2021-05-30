//
//  MainViewModel.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import Foundation
import Combine

protocol MainViewModelProtocol {
    var timer: TimeInterval { get set }
    var timerState: TimerState { get set }
    var previousTimes: [TaskTime] { get set }
    var currentTask: Task? { get set }
    
    var showTasksPopover: Bool { get set }
    
    func onAppear()
    func fetchTimes()
    func fetchCurrentTask()
}

final class MainViewModel: ObservableObject, MainViewModelProtocol {
    @Published var timer: TimeInterval = TimeInterval.init()
    @Published var timerState: TimerState = .pause
    @Published var previousTimes: [TaskTime] = [TaskTime]()
    @Published var currentTask: Task? = nil
    
    @Published var showTasksPopover: Bool = false
    
    private var coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol)
    private var userDefaultsService: TaskUserDefaultsProtocol
    // timer service
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol) = CoreDataService.shared,
         userDefaultsService: TaskUserDefaultsProtocol = UserDefaultsService.shared) {
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
        
        $showTasksPopover
            .filter { $0 == false }
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.fetchCurrentTask()
            }
            .store(in: &cancellableSet)
    }
    
    func onAppear() {
        fetchTimes()
        fetchCurrentTask()
    }
    
    func fetchTimes() {
        previousTimes = coreDataService.fetchTaskTimes()
    }
    
    func fetchCurrentTask() {
        guard let uuid = userDefaultsService.getCurrentTaskID() else { return }
        currentTask = coreDataService.findByUUID(uuid: uuid)
    }
}
