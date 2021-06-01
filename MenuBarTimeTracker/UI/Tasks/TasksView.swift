//
//  TasksView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

// set background or smth for choosed view
protocol ChoosedProtocol {
    associatedtype DataModel
    var choosed: Bool { get set }
    var model: DataModel { get set }
    
    var choosedDelegate: ChoosedProtocolDelegate? { get set }
}

protocol ChoosedProtocolDelegate {
    func setChoosed<DataModel>(model: DataModel)
}

protocol OneOfManyChooseProtocol: ChoosedProtocolDelegate {
    associatedtype DataModel
    var choosed: DataModel? { get set }
    
    func isModelChoosed(_ model: DataModel) -> Bool
}

struct TasksView: View {
    
    @Binding var isShowedSheet: Bool
    
    @StateObject var viewModel = TasksViewModel()
    
    @State var showCreatePopover: Bool = false
    
    var body: some View {
        VStack {
            Text("Your targets")
                .font(.title2)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.tasks) { (task: Task) in
                        TaskCell(choosed: viewModel.isModelChoosed(task), model: task, choosedDelegate: viewModel, menuDelegate: viewModel)
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
                    Text("Add target")
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
