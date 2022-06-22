//
//  AppDelegate.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/5/30.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        guard let window = NSApplication.shared.windows.first,
        let screenFrame = NSScreen.main?.frame else { return }
        window.setFrame(screenFrame, display: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            NSApplication.shared.windows.first?.makeKeyAndOrderFront(self)
        }
        return true
    }

}

