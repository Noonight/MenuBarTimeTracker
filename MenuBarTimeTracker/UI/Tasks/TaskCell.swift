//
//  TaskCell.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

struct TaskCell: View {
    
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.name ?? "")
                .font(.title2)
            Text(task.describe ?? "")
                .font(.caption)
                .fontWeight(.light)
        }
    }
}
