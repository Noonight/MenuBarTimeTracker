//
//  DeveloperView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 01.06.2021.
//

import SwiftUI

struct DeveloperView: View {
    
    @StateObject var viewModel = DeveloperViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("Tasks")
                Divider()
                TextField("Filter by name", text: $viewModel.filterTasksByName)
                LazyVStack {
                    ForEach(viewModel.tasks) { (task: Task) in
                        TaskCell(choosed: viewModel.isModelChoosed(task), model: task, choosedDelegate: viewModel, menuDelegate: viewModel)
                    }
                }
            }
            
            VStack {
                Text("Intervals")
                Divider()
                Picker(selection: $viewModel.sortIntervalsBy,
                       label: Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .foregroundColor(.blue)
                ) {
                    ForEach(TaskTimeSortOptions.allCases, id: \.self) { view in
                        Text(view.rawValue).tag(view)
                    }
                }
                LazyVStack {
                    ForEach(viewModel.intervals) { (interval: TaskTime) in
                        VStack {
                            Text(interval.task?.name ?? "")
                            Text(DateHelper.devFormat(date: interval.time ?? Date()))
                        }
                    }
                }
            }
            
        }
        .frame(type: .full)
        .padding()
    }
}
