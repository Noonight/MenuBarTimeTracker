//
//  MenuController.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 28.05.2021.
//

import AppKit
import SwiftUI

class MenuController: NSObject {
    
    var menu: NSMenu!
    private var settings: NSMenuItem = {
        NSMenuItem(
            title: "Settings",
            action: #selector(openSettings(_:)),
            keyEquivalent: "")
    }()
    private var about: NSMenuItem = {
        NSMenuItem(
            title: "About",
            action: #selector(openAbout(_:)),
            keyEquivalent: "")
    }()
    private var dev: NSMenuItem = {
        NSMenuItem(
            title: "Dev",
            action: #selector(openDev(_:)),
            keyEquivalent: "")
    }()
    private var quit: NSMenuItem = {
        NSMenuItem(
            title: "Quit",
            action: #selector(quit(_:)),
            keyEquivalent: "")
    }()
    
    var coordinator: (Settings & About & Dev)?
    
    convenience init(coordinator: MenuCoordinator) {
        self.init()
        self.coordinator = coordinator
    }
    
    override init() {
        super.init()
        menu = NSMenu(title: "Status Bar Menu")
        
        menu.delegate = self
        settings.target = self
        about.target = self
        dev.target = self
        quit.target = self
        
        menu.addItem(settings)
        menu.addItem(about)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(dev)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(quit)
    }
    
    @objc func openSettings(_ sender: NSMenu) {
        coordinator?.presentSettings()
    }
    
    @objc func openAbout(_ sender: NSMenu) {
        coordinator?.presentAbout()
    }
    
    @objc func openDev(_ sender: NSMenu) {
        coordinator?.presentDev()
    }
    
    @objc func quit(_ sender: NSMenu) {
        NSApplication.shared.terminate(sender)
    }
}

extension MenuController: NSMenuDelegate { }
