//
//  ContentView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 27.05.2021.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    @State var showTasksSheet: Bool = false
    
    var body: some View {
        ZStack {
            empty
            VStack {
                VStack(alignment: .center, spacing: 8) {
                    Text("00:00")
                        .font(.largeTitle)
                    Text(viewModel.currentTask?.name ?? "---")
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
                        showTasksSheet = true
                    } label: {
                        Image(systemName: showTasksSheet ? "cursorarrow.click" : "cursorarrow.click.2")
                    }
                    .popover(isPresented: $showTasksSheet) { TasksView(isShowedSheet: $showTasksSheet) }
                    
                    Spacer()
                    
                    timerButton
                    
                    Spacer()
                }
            }
            .padding(.bottom, 4)
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
                    
                } label: {
                    Image(systemName: "pause.fill")
                        .foregroundColor(.red)
                }
                Button {
                    
                } label: {
                    Image(systemName: "stop.fill")
                        .foregroundColor(.red)
                }
            }
        case .pause:
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "stop.fill")
                        .foregroundColor(.red)
                }
                Button {
                    
                } label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .foregroundColor(.red)
                }
            }
        case .inactive:
            Button {
                
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
                Text("There's no time intervals for today")
                    .multilineTextAlignment(.center)
            }
        }
    }
}
