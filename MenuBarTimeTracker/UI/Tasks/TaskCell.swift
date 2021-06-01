//
//  TaskCell.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

protocol TaskMenuDelegate {
    func edit(task: Task)
    func delete(task: Task)
}

struct TaskCell: View, ChoosedProtocol {
    typealias ChoosedModel = Task
    
    var choosed: Bool
    @ObservedObject var model: ChoosedModel
    var choosedDelegate: ChoosedProtocolDelegate?
    
    var menuDelegate: TaskMenuDelegate?
    
    @State var isShowEditPopover: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.name ?? "")
                .font(.title2)
            Text(model.describe ?? "")
                .font(.caption)
                .fontWeight(.light)
        }
        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
        .padding(4)
        .background(choosed ? Color(NSColor.selectedControlColor) : nil)
        .contentShape(Rectangle())
        .cornerRadius(5)
        .onTapGesture {
            choosedDelegate?.setChoosed(model: model)
        }
        .popover(isPresented: $isShowEditPopover) {
            EditTaskView(isPopovered: $isShowEditPopover, task: model, editTaskDelegate: self)
        }
        .contextMenu {
            contextMenu
        }
    }
    
    var contextMenu: some View {
        VStack {
            Button("Edit") {
                isShowEditPopover = true
            }
            Button("Delete") {
                menuDelegate?.delete(task: model)
            }
        }
    }
}

extension TaskCell: EditTaskDelegate {
    func edit(task: Task) {
        menuDelegate?.edit(task: task)
    }
}
