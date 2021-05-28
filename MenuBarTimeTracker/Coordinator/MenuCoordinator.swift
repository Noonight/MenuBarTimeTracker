//
//  MenuCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

class MenuCoordinator: MenuCoordinatorProtocol, Settings, About {
    
    var windowController: NSWindowController
    
    required init(windowController: NSWindowController) {
        self.windowController = windowController
    }
    
    func presentSettings() {
        let child = SettingsCoordinator(windowController: windowController)
        child.start()
    }
    
    func presentAbout() {
        let child = AboutCoordinator(windowController: windowController)
        child.start()
    }
}
