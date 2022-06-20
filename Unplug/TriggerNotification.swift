
import Foundation
import UserNotifications

func scheduleNotification() {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "It's time to unplug!"
    content.body = "The current carbon intensity is " + ModelData.shared.globalIndex + ", unplug your MacBook if you can."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "fizzbuzz"]
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 30
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
    
    statusMenuColour()
    
}
