//
//  MainViewModel.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import Foundation

protocol MainViewModelProtocol {
    var timer: TimeInterval { get set }
    var timerState: TimerState { get set }
    var previousTimes: [TaskTime] { get set }
    var currentTask: Task? { get set }
    
    func onAppear()
    func fetchTimes()
}

final class MainViewModel: ObservableObject, MainViewModelProtocol {
    @Published var timer: TimeInterval = TimeInterval.init()
    @Published var timerState: TimerState = .pause
    @Published var previousTimes: [TaskTime] = [TaskTime]()
    @Published var currentTask: Task? = nil
    
    private var coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol)
    // timer service
    
    init(coreDataService: (TaskTimeCoreDataServiceProtocol & TaskCoreDataServiceProtocol) = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
    
    func onAppear() {
        fetchTimes()
    }
    
    func fetchTimes() {
        previousTimes = coreDataService.fetchTaskTimes()
    }
}
