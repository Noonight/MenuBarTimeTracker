//
//  Coordinator.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

protocol CoordinatorProtocol: AnyObject {
    var parent: MenuCoordinatorProtocol? { get set }
    var windowController: WindowController { get set }
    
    init(windowController: WindowController)
    
    func start()
    
    func finish()
}
