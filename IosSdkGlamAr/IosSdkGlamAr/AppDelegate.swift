import UIKit
import SwiftUI


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    
    
    // Declare an instance variable to hold the main window of the application
    var window: UIWindow?
    
    
    // This method is called when the app finishes launching
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Add any initial setup or configuration code here
       
        
        // Uncomment the following line if you are integrating Unity in your project
        // Unity.shared.setHostMainWindow(window)
        
        // Return true to indicate that the app has finished launching successfully
        return true
    }
    
   
    
    // This method is used to provide a scene configuration for a connecting scene session
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // You need to create the `SceneDelegate` class for this to work.
        
        // Create a new UISceneConfiguration and set its name and session role
        let sceneConfig = UISceneConfiguration(
            name: nil, // You can specify a scene name here if needed
            sessionRole: connectingSceneSession.role
        )
        
        // Set the delegateClass to SceneDelegate.self to associate this configuration with your custom SceneDelegate
        sceneConfig.delegateClass = SceneDelegate.self
        
        // Return the created UISceneConfiguration
        return sceneConfig
    }
    
}

