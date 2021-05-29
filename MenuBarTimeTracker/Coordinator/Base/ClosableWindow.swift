//
//  ClosableWindow.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//

import AppKit

protocol ClosableWindowDelegate {
    func close()
}
/*
 ref: https://github.com/onmyway133/blog/issues/312
 */
class ClosableWindow: NSWindow {
    
    var closableDelegate: ClosableWindowDelegate?
    
    override func close() {
        super.close()
        closableDelegate?.close()
    }
}
