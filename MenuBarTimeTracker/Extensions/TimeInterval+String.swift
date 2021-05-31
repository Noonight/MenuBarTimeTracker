//
//  TimeInterval+String.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 31.05.2021.
//

import Foundation

enum TimeIntervalFormat {
    case HHmm
    case HHmmss
    case ss
}

extension TimeInterval{
    
    func toString(format: TimeIntervalFormat) -> String {
        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        switch format {
        case .HHmm:
            return String(format: "%0.2d:%0.2d", hours, minutes)
        case .HHmmss:
            return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
        case .ss:
            return String(format: "%0.2d", seconds)
        }
    }
}
