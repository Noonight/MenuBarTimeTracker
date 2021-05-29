//
//  AppCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Cocoa
import SwiftUI

class SettingsCoordinator: CoordinatorProtocol {
    weak var parent: MenuCoordinatorProtocol?
    var windowController: NSWindowController
    
    private let contentView = NSHostingView(rootView: SettingsView())
    
    required init(windowController: NSWindowController) {
        self.windowController = windowController
        
        let window = ClosableWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 460),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Settings Window")
        window.title = "Settings"
        window.contentView = contentView
        
        window.closableDelegate = self
        
        windowController.window = window
    }
    
    func start() {
        windowController.showWindow(nil)
    }
    
    func finish() {
        parent?.childDidFinish(child: self)
    }
}

extension SettingsCoordinator: ClosableWindowDelegate {
    func close() {
        finish()
    }
}
