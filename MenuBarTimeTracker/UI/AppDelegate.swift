//
//  AppDelegate.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 27.05.2021.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var popover: NSPopover!
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1000, height: 1000),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        
        let contentView = MainView()
        
        popover = NSPopover()
        popover.contentSize = NSSize(width: 160, height: 160)
        popover.behavior = .transient
        popover.appearance = NSAppearance(named: NSAppearance.Name.vibrantLight)
        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentViewController?.view.window?.becomeKey()
        
        statusBar = StatusBarController(popover, menu: MenuController(coordinator: MenuCoordinator(window: window)))
    }
}

