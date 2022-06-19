
import AppKit
import Foundation



func statusMenu() {
    let menu = NSMenu()
    menu.addItem(withTitle: ModelData.shared.currentCarbonIntensityMenuTitle + ModelData.shared.globalIndex.capitalized, action: nil, keyEquivalent: "")
    menu.addItem(NSMenuItem.separator())
    menu.addItem(withTitle: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
    ModelData.shared.statusItem.menu = menu
}

