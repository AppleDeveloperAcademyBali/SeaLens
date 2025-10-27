import SwiftUI

@main
struct SeaLensApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notifcation: Notification) {
        DispatchQueue.main.async {
            if let window = NSApplication.shared.windows.first {
                window.minSize = NSSize(width: 2000, height: 1400)
                
            }
        }
    }
}
