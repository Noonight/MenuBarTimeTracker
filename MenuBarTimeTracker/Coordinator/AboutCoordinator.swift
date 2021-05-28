//
//  AboutCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Cocoa
import SwiftUI

class AboutCoordinator: CoordinatorProtocol {
    
    var windowController: NSWindowController
    
    required init(windowController: NSWindowController) {
        self.windowController = windowController
    }
    
    func start() {
        let contentView = NSHostingView(rootView: AboutView())
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 460),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("About Window")
        window.title = "About"
        window.contentView = contentView
        window.makeKeyAndOrderFront(nil)
        
        windowController.window = window
    }
}
