
import Cocoa
import Foundation


func statusMenuColour() {
    if ModelData.shared.globalIndex == "very high" {
        ModelData.shared.buttonColour = .red
    } else if ModelData.shared.globalIndex == "high" {
        ModelData.shared.buttonColour = .orange
    } else if ModelData.shared.globalIndex == "moderate" {
        ModelData.shared.buttonColour = .yellow
    } else if ModelData.shared.globalIndex == "low" {
        ModelData.shared.buttonColour = .green
    } else if ModelData.shared.globalIndex == "very low" {
        ModelData.shared.buttonColour = .green
    }
    DispatchQueue.main.async {
        if let button = ModelData.shared.statusItem.button {
            button.image = NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: "1")?.withSymbolConfiguration(.init(hierarchicalColor: ModelData.shared.buttonColour))
        }
    }
    statusMenu()
}
