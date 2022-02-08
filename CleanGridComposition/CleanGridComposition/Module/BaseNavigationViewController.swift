//
//  BaseNavigationViewController.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        nvc.navigationBar.barStyle = .default
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = LColor.surface
        appearance.titleTextAttributes = [
            .foregroundColor: LColor.primary,
            .font: AppFont.regularFont(16)
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.tintColor = LColor.primary
    }
    
}

extension UIBarButtonItem {
    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return menuBarItem
    }
}
extension UIViewController {
    func addRightBarItem(image: String, action: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: action, imageName: image)
    }
    func customiseBackItem(image: String, action: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: image),
            style: .plain,
            target: self,
            action: action
        )
    }
    
  
}

extension UIViewController: UIGestureRecognizerDelegate {
    func enableInteractiveGesture() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}
