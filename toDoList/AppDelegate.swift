//
//  AppDelegate.swift
//  toDoList
//
//  Created by Admin on 17.10.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: TableViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}


