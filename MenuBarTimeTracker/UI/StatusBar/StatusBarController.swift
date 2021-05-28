//
//  StatusBarController.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 27.05.2021.
//

import AppKit

class StatusBarController: NSObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var statusBarIcon: NSImage = {
        let icon = NSImage(named: "StatusBarIcon")
        icon?.size = NSSize(width: 16.0, height: 16.0)
        icon?.isTemplate = true
        return icon!
    }()
    
    private var menuController: MenuController!
    
    private var eventMonitor: EventMonitor?
    
    init(_ popover: NSPopover, menu: MenuController) {
        super.init()
        self.popover = popover
        
        statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        menuController = menu
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = statusBarIcon
            
            statusBarButton.target = self
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)
    }
    
    @objc func togglePopover(sender: NSStatusItem) {
        guard let event = NSApp.currentEvent else { return }
        
        if event.type == NSEvent.EventType.leftMouseUp {
            if popover.isShown {
                hidePopover(sender)
            } else {
                showPopover(sender)
            }
        }
        if event.type == NSEvent.EventType.rightMouseUp {
            statusItem.menu = menuController.menu
            statusItem.button?.performClick(nil)
            
            statusItem.menu = nil
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
            eventMonitor?.start()
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func mouseEventHandler(_ event: NSEvent?) {
        if(popover.isShown) {
            hidePopover(event!)
        }
    }
}
