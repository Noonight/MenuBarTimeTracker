//
//  Coordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

protocol CoordinatorProtocol: AnyObject {
    var window: NSWindow { get set }
    
    init(window: NSWindow)
    
    func start()
}
