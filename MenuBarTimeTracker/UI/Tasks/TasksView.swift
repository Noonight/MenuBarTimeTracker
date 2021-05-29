//
//  TasksView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

struct TasksView: View {
    
    @Binding var isShowedSheet: Bool
    
    @StateObject var viewModel = TasksViewModel()
    
    @State var showCreatePopover: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tasks) { (task: Task) in
                        TaskCell(task: task)
                    }
                }
            }
            HStack {
                Button {
                    isShowedSheet = false
                } label: {
                    Text("Close")
                }
                Button {
                    showCreatePopover = true
                } label: {
                    Text("Create")
                }
                .popover(isPresented: $showCreatePopover) { createTaskView }
            }
        }
        .frame(width: CGFloat(windowWidth / 2), height: CGFloat(windowHeight / 2))
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    var createTaskView: some View {
        CreateTaskView(isPopovered: $showCreatePopover, creatingDelegate: viewModel.self)
    }
}
