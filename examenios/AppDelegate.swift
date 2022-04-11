//
//  AppDelegate.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var standard: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Window Settings
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MenuViewController())
        window?.makeKeyAndVisible()
        AppDelegate.standard.window = window
        
        // MARK: - Firebase Settings
        FirebaseApp.configure()
        
        // MARK: - Navigation Bar Settings
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowImage = UIImage()
            appearance.backgroundImage = UIImage()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = .clear
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .systemBlue
        
        return true
    }
}

