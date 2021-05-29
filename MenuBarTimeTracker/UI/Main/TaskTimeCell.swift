//
//  TaskTimeCell.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

struct TaskTimeCell: View {
    
    let taskTime: TaskTime
    
    var body: some View {
        HStack {
            Text(taskTime.task?.name ?? "")
                .fontWeight(.ultraLight)
            Spacer()
            Text(DateHelper.format(date: taskTime.time ?? Date()))
                .fontWeight(.ultraLight)
        }
    }
}
