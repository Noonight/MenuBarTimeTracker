//
//  MainViewModel.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import Foundation
import Combine

enum MainViewState: ViewStates {
    case noIntervals
    case noTask
    case good
}

protocol MainViewModelProtocol {
    var timerInterval: TimeInterval { get set }
    var timerState: TimerState { get set }
    var previousTimes: [TaskTime] { get set }
    var currentTask: Task? { get set }
    
    var showTasksPopover: Bool { get set }
    
    func onAppear()
    func fetchTimes()
    func fetchCurrentTask()
    
    func startTimer()
    func pauseTimer()
    func stopTimer()
}

final class MainViewModel: ObservableObject, MainViewModelProtocol, ViewStateProtocol {
    @Published var timerInterval: TimeInterval = TimeInterval.init()
    @Published var timerState: TimerState = .pause
    @Published var previousTimes: [TaskTime] = [TaskTime]()
    @Published var currentTask: Task? = nil
    
    @Published var viewState: MainViewState = .noTask
    
    @Published var showTasksPopover: Bool = false
    
    private var coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol)
    private var userDefaultsService: TaskUserDefaultsProtocol
    private var timerService: TimerService
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol) = CoreDataService.shared,
         userDefaultsService: TaskUserDefaultsProtocol = UserDefaultsService.shared,
         timerService: TimerService = TimerService.shared) {
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
        self.timerService = timerService
        
        $showTasksPopover
            .filter { $0 == false }
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.fetchCurrentTask()
                self.fetchTimes()
                self.checkState()
            }
            .store(in: &cancellableSet)
        
        timerService
            .$interval
            .receive(on: DispatchQueue.main)
            .assign(to: \.timerInterval, on: self)
            .store(in: &cancellableSet)
        
        timerService
            .$state
            .receive(on: DispatchQueue.main)
            .assign(to: \.timerState, on: self)
            .store(in: &cancellableSet)
    }
    
    private func updateUI() {
        fetchCurrentTask()
        fetchTimes()
        checkState()
    }
    
    // MARK: - MainViewModelProtocol
    
    func onAppear() {
        updateUI()
    }
    
    func fetchTimes() {
        previousTimes = coreDataService.fetchTaskTimes(sortBy: .newer, filterByTask: currentTask)
    }
    
    func fetchCurrentTask() {
        guard let uuid = userDefaultsService.getCurrentTaskID() else { return }
        currentTask = coreDataService.findByUUID(uuid: uuid)
    }
    
    // MARK: - Timer behavior
    
    func startTimer() {
        timerService.start()
    }
    
    func pauseTimer() {
        timerService.pause()
    }
    
    func stopTimer() {
        
        guard let curTask = currentTask,
              let zeroDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        else { return }
        let curDate = Date(timeInterval: timerInterval, since: zeroDate)
    
        coreDataService.addTaskTime(
            time: curDate,
            task: curTask)
        
        timerService.stop()
        
        updateUI()
    }
    
    // MARK: - ViewStateProtocol
    
    func checkState() {
        if currentTask == nil {
            viewState = .noTask
            return
        }
        if currentTask != nil && previousTimes.count == 0 {
            viewState = .noIntervals
            return
        }
        viewState = .good
    }
}

// MARK: - CreateTaskDelegate

extension MainViewModel: CreateTaskDelegate {
    func create(name: String, description: String) {
        let newTask: Task = coreDataService.addNewTask(name: name, description: description)
        if let uuid = newTask.id {
            userDefaultsService.setCurrentTaskID(uuid)
        }
        updateUI()
    }
}
