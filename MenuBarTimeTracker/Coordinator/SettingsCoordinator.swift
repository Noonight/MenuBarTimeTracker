//
//  AppCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Cocoa
import SwiftUI

class SettingsCoordinator: CoordinatorProtocol {
    
    var window: NSWindow
    
    required init(window: NSWindow) {
        self.window = window
    }
    
    func start() {
        let contentView = NSHostingView(rootView: SettingsView())
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 460),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Settings Window")
        window.title = "Settings"
        window.contentView = contentView
        window.makeKeyAndOrderFront(nil)
    }
    
    deinit {
        print("deinit")
    }
}
