//
//  MenuCoordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

class MenuCoordinator: MenuCoordinatorProtocol, Settings, About {
    var childs: [CoordinatorProtocol] = [CoordinatorProtocol]() {
        didSet {
            print(childs)
        }
    }
    var windowController: WindowController
    
    required init(windowController: WindowController) {
        self.windowController = windowController
    }
    
    func childDidFinish(child: CoordinatorProtocol) {
        print(child)
        for (index, coordinator) in childs.enumerated() {
            if coordinator === child {
                childs.remove(at: index)
                break
            }
        }
    }
    
    func presentSettings() {
        if !childs.contains(where: { $0 is SettingsCoordinator }) {
            let child = SettingsCoordinator(windowController: windowController)
            child.parent = self
            childs.append(child)
            child.start()
        }
    }
    
    func presentAbout() {
        if !childs.contains(where: { $0 is AboutCoordinator }) {
            let child = AboutCoordinator(windowController: windowController)
            child.parent = self
            childs.append(child)
            child.start()
        }
        
    }
}
