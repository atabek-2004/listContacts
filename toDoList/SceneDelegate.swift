//
//  SceneDelegate.swift
//  toDoList
//
//  Created by Admin on 17.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: TableViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}



