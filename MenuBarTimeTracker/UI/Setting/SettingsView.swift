//
//  SettingsView.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State var toggle: Bool = false
    
    var body: some View {
        VStack {
            Text("Setting property")
            Divider()
            Toggle(isOn: $toggle) {
                Text("Toggle")
            }
        }
        .padding()
    }
}
