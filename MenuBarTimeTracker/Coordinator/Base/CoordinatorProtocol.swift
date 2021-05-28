//
//  Coordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

protocol CoordinatorProtocol: AnyObject {
    var windowController: NSWindowController { get set }
    
    init(windowController: NSWindowController)
    
    func start()
}
