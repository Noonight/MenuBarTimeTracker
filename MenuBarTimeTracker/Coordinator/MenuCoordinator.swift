//
//  MenuCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

class MenuCoordinator: MenuCoordinatorProtocol, Settings, About {
    
    var window: NSWindow
    
    required init(window: NSWindow) {
        self.window = window
    }
    
    func presentSettings() {
        let child = SettingsCoordinator(window: window)
        child.start()
    }
    
    func presentAbout() {
        let child = AboutCoordinator(window: window)
        child.start()
    }
}
