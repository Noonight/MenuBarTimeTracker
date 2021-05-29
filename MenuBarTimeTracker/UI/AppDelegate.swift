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

    var windowController: WindowController!
    var popover: NSPopover!
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
//        windowController = NSWindowController(window: nil)
        windowController = WindowController(window: nil)
        
        let contentView = MainView()
        
        popover = NSPopover()
        popover.contentSize = NSSize(width: 160, height: 160)
        popover.behavior = .transient
        popover.appearance = NSAppearance(named: NSAppearance.Name.vibrantLight)
        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentViewController?.view.window?.becomeKey()
        
        statusBar = StatusBarController(popover, menu: MenuController(coordinator: MenuCoordinator(windowController: windowController)))
    }
}

