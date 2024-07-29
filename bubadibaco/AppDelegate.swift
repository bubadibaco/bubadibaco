//
//  AppDelegate.swift
//  bubadibaco
//
//  Created by Michael Eko on 15/07/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Create a new instance of SplashScreenViewController
        let splashScreenViewController = SplashScreenViewController()

        // Create a new UIWindow with the screen's bounds
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Set the root view controller to the SplashScreenViewController
        window?.rootViewController = splashScreenViewController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        
        return true
    }
}
