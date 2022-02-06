//
//  SceneDelegate.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        navController.view.backgroundColor = LColor.surface
        // MARK: send that into our coordinator so that it can display view controllers
        coordinator = MainCoordinator(navigationController: navController)
        // MARK: tell the coordinator to take over control
        coordinator?.start()
        // MARK: create a basic UIWindow and activate it
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

