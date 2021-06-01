//
//  DevCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 02.06.2021.
//

import Cocoa
import SwiftUI

class DevCoordinator: CoordinatorProtocol {
    weak var parent: MenuCoordinatorProtocol?
    var windowController: NSWindowController
    
    private let contentView = NSHostingView(rootView: DeveloperView())
    
    required init(windowController: NSWindowController) {
        self.windowController = windowController
        
        let window = ClosableWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 700),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Dev Window")
        window.title = "Dev Menu"
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

extension DevCoordinator: ClosableWindowDelegate {
    func close() {
        finish()
    }
}
