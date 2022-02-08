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
    func dismiss()
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
    func showDetailPage(viewModel: ListingItemViewModel) {
        let vc = DetailViewController()
        vc.coordinator = self
        let presenter = DetailPresenter(output: WeakRef(vc))
        presenter.didFetch(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showWishlist() {
        let vc = WishlistViewController()
        vc.coordinator = self
        let presenter = WishlistPresenter(output: WeakRef(vc))
        let usecase = WishlistUseCase(output: presenter)
        usecase.fetch()
        let nvc = BaseNavigationViewController(rootViewController: vc)
        nvc.modalPresentationStyle = .fullScreen
        navigationController.present(nvc, animated: true)
    }
    func dismiss() {
        if let isPresented = navigationController.visibleViewController?.isModal, isPresented {
            navigationController.dismiss(animated: true)
        } else {
            navigationController.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
