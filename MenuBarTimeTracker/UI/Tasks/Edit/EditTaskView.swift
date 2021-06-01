//
//  EditTaskView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 01.06.2021.
//

import SwiftUI

protocol EditTaskDelegate {
    func edit(task: Task)
}

struct EditTaskView: View {
    
    @Binding var isPopovered: Bool
    
    var task: Task?
    @State var name: String = ""
    @State var description: String = ""
    
    var editTaskDelegate: EditTaskDelegate?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Name")
                    .font(.headline)
                    .fontWeight(.light)
                TextField("", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("Description")
                    .font(.headline)
                    .fontWeight(.light)
                TextEditor(text: $description)
                    .frame(height: 50.0)
            }
            
            HStack {
                Button {
                    self.isPopovered = false
                } label: {
                    Text("Cancel")
                }
                Button {
                    editTaskDelegate?.edit(task: editTask())
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.isPopovered = false
                    }
                } label: {
                    Text("Save")
                }
            }
        }
        .onAppear {
            onAppear()
        }
        .padding()
    }
    
    private func onAppear() {
        name = task!.name ?? ""
        description = task!.describe ?? ""
    }
    
    private func editTask() -> Task {
        task!.name = name
        task!.describe = description
        return task!
    }
}
