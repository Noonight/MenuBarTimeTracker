//
//  TaskCell.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

struct TaskCell: View, ChoosedProtocol {
    typealias ChoosedModel = Task
    
    var choosed: Bool
    var model: ChoosedModel
    var choosedDelegate: ChoosedProtocolDelegate?
    
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
    }
}
