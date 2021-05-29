//
//  AboutCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Cocoa
import SwiftUI

class AboutCoordinator: CoordinatorProtocol {
    weak var parent: MenuCoordinatorProtocol?
    var windowController: WindowController
    
    private let contentView = NSHostingView(rootView: AboutView())
    
    required init(windowController: WindowController) {
        self.windowController = windowController
        self.windowController.delegate = self
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 460),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("About Window")
        window.title = "About"
        window.contentView = contentView
        
        windowController.window = window
    }
    
    func start() {
        windowController.showWindow(nil)
    }
    
    func finish() {
        parent?.childDidFinish(child: self)
    }
}

extension AboutCoordinator: WindowControllerDelegate {
    func windowShouldClose() {
        finish()
    }
}
