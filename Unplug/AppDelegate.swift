
import Cocoa
import Foundation

class ModelData: NSObject {
    static let shared: ModelData = ModelData()
    public var globalIndex = ""
    public var buttonColour: NSColor!
    public var statusItem: NSStatusItem!
    public var currentCarbonIntensityMenuTitle:String = "Current Carbon Intensity: "
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        ModelData.shared.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = ModelData.shared.statusItem.button {
            button.image = NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: "Unplug App Icon")
        }
        _ = Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(AppDelegate.startApp), userInfo: nil, repeats: true)
        startApp()
    }
    @objc func startApp() {
        getIntensity()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
