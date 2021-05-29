//
//  MenuCoordinatorP.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import Foundation
import Cocoa

protocol MenuCoordinatorProtocol: AnyObject {
    var childs: [CoordinatorProtocol] { get set }
    var windowController: NSWindowController { get set }
    
    init(windowController: NSWindowController)
    
    func childDidFinish(child: CoordinatorProtocol)
}
