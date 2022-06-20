
import Foundation
import UserNotifications

//let center = UNUserNotificationCenter.current()

func requestAuth () {
    ModelData.shared.center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            print("Yay!")
        } else {
            print("D'oh")
        }
    }
    scheduleNotification()
}
