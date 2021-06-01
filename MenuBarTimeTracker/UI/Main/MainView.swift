//
//  ContentView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 27.05.2021.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    @State var showCreateTaskPopover: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .center, spacing: 4) {
                    Text(viewModel.timerInterval.toString(format: .HHmmss))
                        .font(.largeTitle)
                    Text(viewModel.currentTask?.name ?? currentTaskPlaceholder)
                        .font(.title3)
                        .fontWeight(.light)
                }
                
                stateOfView
                
                Spacer()
                Divider()
                HStack {
                    
                    Button {
                        viewModel.showTasksPopover = true
                    } label: {
                        Image(systemName: viewModel.showTasksPopover ? "cursorarrow.click.2" : "cursorarrow.click")
                    }
                    .popover(isPresented: $viewModel.showTasksPopover) { TasksView(isShowedSheet: $viewModel.showTasksPopover) }
                    
                    Spacer()
                    
                    timerButton
                    
                    Spacer()
                }
                .padding(.leading, 8)
            }
            .padding(.bottom, 8)
            .padding(.top, 4)
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    @ViewBuilder var stateOfView: some View {
        switch viewModel.viewState {
        case .noTask:
            VStack(alignment: .center, spacing: 8) {
                Button {
                    showCreateTaskPopover = true
                } label: {
                    Text("Add")
                }
                .popover(isPresented: $showCreateTaskPopover) {
                    CreateTaskView(isPopovered: $showCreateTaskPopover, creatingDelegate: viewModel)
                }
                Text("To start add your first target or choose one")
                    .font(.caption)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
            }
        case .noIntervals:
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "moon.stars.fill")
                Text("There's no intervals for today")
                    .font(.caption)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
            }
        case .good:
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.previousTimes) { (taskTime: TaskTime) in
                        TaskTimeCell(taskTime: taskTime)
                    }
                }
            }
        }
    }
    
    @ViewBuilder var timerButton: some View {
        switch viewModel.timerState {
        case .tracking:
            HStack {
                Button {
                    viewModel.pauseTimer()
                } label: {
                    Image(systemName: "pause.fill")
                        .foregroundColor(.red)
                }
                Button {
                    viewModel.stopTimer()
                } label: {
                    Image(systemName: "stop.fill")
                        .foregroundColor(.red)
                }
            }
        case .pause:
            HStack {
                Button {
                    viewModel.startTimer()
                } label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .foregroundColor(.red)
                }
                Button {
                    viewModel.stopTimer()
                } label: {
                    Image(systemName: "stop.fill")
                        .foregroundColor(.red)
                }
            }
        case .stop:
            Button {
                viewModel.startTimer()
            } label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .foregroundColor(.red)
            }
        }
    }
}
