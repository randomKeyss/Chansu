import SwiftUI
import UserNotifications

@main
struct ChansuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("center")
        let center  = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Permission granted.")
                self.scheduleNotification()
            } else {
                print("Permission denied.")
            }
        }

        return true
    }

    func scheduleNotification() {
        print("schedule notification")
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "Body"
        content.sound = UNNotificationSound.default

        // Get current date components
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        // Add one second
        dateComponents.second! += 1

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: "notification.id.1", content: content, trigger: trigger)

        center.add(request) { (error) in
            if let error = error {
                print("Error adding notification: \(error)")
            } else {
                print("Successfully added notification request")
            }
        }
    }

}
