//
//  WindowController.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import AppKit

protocol WindowControllerDelegate {
    func windowShouldClose()
}

class WindowController: NSWindowController, NSWindowDelegate {
    
    var delegate: WindowControllerDelegate?
    
    override func windowWillLoad() {
        print("window will load")
    }
    
    override func windowDidLoad() {
        window?.delegate = self
        print("windowDidLoad")
    }
    
    func windowWillClose(_ notification: Notification) {
        print("windowWillClose")
        delegate?.windowShouldClose()
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        print("windowShouldClose")
        delegate?.windowShouldClose()
        return true
    }
}
