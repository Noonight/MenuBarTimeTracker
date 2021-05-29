//
//  CreateTaskView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import SwiftUI

protocol CreateTaskDelegate {
    func create(name: String, description: String)
}

struct CreateTaskView: View {
    
    @Binding var isPopovered: Bool
    
    @State var name: String = ""
    @State var description: String = ""
    
    var creatingDelegate: CreateTaskDelegate?
    
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
                    creatingDelegate?.create(name: name, description: description)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.isPopovered = false
                    }
                } label: {
                    Text("Create")
                }
            }
        }
        .padding()
    }
}
