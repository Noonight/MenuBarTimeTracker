//
//  ContentView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 27.05.2021.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            empty
            VStack {
                VStack(alignment: .center, spacing: 4) {
                    Text(viewModel.timerInterval.toString())
                        .font(.largeTitle)
                    Text(viewModel.currentTask?.name ?? currentTaskPlaceholder)
                        .font(.caption)
                        .fontWeight(.light)
                }
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.previousTimes) { (taskTime: TaskTime) in
                            TaskTimeCell(taskTime: taskTime)
                        }
                    }
                }
                
                Spacer()
                Divider()
                HStack {
                    
                    Button {
                        viewModel.showTasksPopover = true
                    } label: {
                        Image(systemName: viewModel.showTasksPopover ? "cursorarrow.click" : "cursorarrow.click.2")
                    }
                    .popover(isPresented: $viewModel.showTasksPopover) { TasksView(isShowedSheet: $viewModel.showTasksPopover) }
                    
                    Spacer()
                    
                    timerButton
                    
                    Spacer()
                }
                .padding(.leading, 8)
            }
            .padding(.bottom, 8)
            .onAppear {
                viewModel.onAppear()
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
    
    @ViewBuilder var empty: some View {
        if viewModel.previousTimes.count == 0 {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "moon.stars.fill")
                Text("There's no intervals for today")
                    .font(.caption)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
