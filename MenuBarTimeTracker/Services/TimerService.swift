//
//  TimerService.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 31.05.2021.
//

import Foundation
import Combine

protocol TimerServiceProtocol {
    var interval: TimeInterval { get set }
    var state: TimerState { get set }
    
    func start()
    func pause()
    func stop()
}

final class TimerService: ObservableObject, TimerServiceProtocol {
    @Published var interval: TimeInterval = 0
    @Published var state: TimerState = .stop
    
    static let shared = TimerService()
    
    private var timer: Timer?
    
    func start() {
        state = .tracking
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer: Timer) in
            self.interval += 0.1
        })
    }
    
    func pause() {
        state = .pause
        timer?.invalidate()
    }
    
    func stop() {
        state = .stop
        timer?.invalidate()
        interval = 0.0
    }
}
