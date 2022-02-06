//
//  MainCoordinator.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
class MainCoordinator: Coordinator {
    // MARK: We are not using it here it is always Empty
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = ListingViewController()
        vc.coordinator = self
        let presenter = ListingPresenter(output: WeakRef(vc))
        let usecase = ListingUseCase(output: presenter)
        usecase.fetch()
        navigationController.pushViewController(vc, animated: true)
    }
}
