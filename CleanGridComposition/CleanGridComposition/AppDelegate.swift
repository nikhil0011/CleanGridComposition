//
//  AppDelegate.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
import CoreData

let LColor = Theme.shared.light
let DColor = Theme.shared.dark
let AppFont = Theme.shared.font

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        overrideApplicationThemeStyle()

        Theme.shared.setStyle(app: .catalogue, font: nil)
        return true
    }
}


extension AppDelegate {
    func overrideApplicationThemeStyle() {
        if #available(iOS 13.0, *) {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        } else {
        }
    }
}
