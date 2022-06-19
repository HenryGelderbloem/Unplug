//
//  AppDelegate.swift
//  Unplug
//
//  Created by Henry Gelderbloem on 15/06/2022.
//

import Cocoa
import Foundation
import UserNotifications

struct carbonIntensity:Codable {
    var data: [Datum]
}

struct Datum:Codable {
    var from, to: String
    var intensity: IntensityClass
}

struct IntensityClass:Codable {
    var forecast, actual: Int?
    var index: String
}

class ModelData: NSObject {
    static let shared: ModelData = ModelData()
    public var globalIndex = ""
    public var buttonColour: NSColor = .white
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: "1")
        }
        var decodeAPITimer = Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(AppDelegate.decodeAPI), userInfo: nil, repeats: true)
        decodeAPI()
    }

    @objc func decodeAPI(){
        guard let url = URL(string: "https://api.carbonintensity.org.uk/intensity") else{return}
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let tasks = try decoder.decode(carbonIntensity.self, from: data)
                    let subTasks = (tasks.data)
                    ModelData.shared.globalIndex = subTasks[0].intensity.index
                }catch{
                    print("This is the error:", error)
                }
                setupMenus()
                func setupMenus() {
                    
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
                    if let button = self.statusItem.button {
                        button.image = NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: "1")?.withSymbolConfiguration(.init(hierarchicalColor: ModelData.shared.buttonColour))
                    }
                    
                    let currentCarbonIntensityMenuTitle = "Current Carbon Intensity: "
                    
                    let menu = NSMenu()
                    menu.addItem(NSMenuItem(title: currentCarbonIntensityMenuTitle + ModelData.shared.globalIndex.capitalized , action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
                    menu.addItem(NSMenuItem.separator())
                    menu.addItem(NSMenuItem(title: "Quit Unplug", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
                    self.statusItem.menu = menu
                }
            }
        }
        task.resume()
    }
    
    /*
    func setupMenus() {
        let menu = NSMenu()
        
        //print("setupMenus scope:", testOne.shared.currentIntensity)
        
        menu.addItem(NSMenuItem(title: "ModelData.shared.globalIndex" , action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Unplug", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }*/
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
