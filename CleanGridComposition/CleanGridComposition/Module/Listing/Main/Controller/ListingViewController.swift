//
//  ListingViewController.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//


import UIKit

class ListingViewController: UIViewController {
    enum SectionType {
        case catalogue
    }
    weak var coordinator: MainCoordinator?
    var dataSource: ListingDataSource?
    private let manager: WishlistManager = WishlistManager()
    lazy var listingView: ListingView = ListingView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface500
    }
    func setupView() {
        self.view.stack(listingView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "New In"
        self.title = "Listing"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: AppFont.mediumFont(20)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(navigateToWishlist), imageName: UIImage.App.wishlist)
        self.navigationController?.navigationBar.tintColor = UIColor.black

        setupView()
        ActivityIndicator.shared.showProgressView(self.view)
    }
    @objc func navigateToWishlist() {
        coordinator?.showWishlist()
    }
    private func setupDataSource(viewModel: ListingViewModel) {
        dataSource = ListingDataSource(collectionView: listingView.collectionView, array: viewModel.listOfItemVM())
        dataSource?.collectionItemSelectionHandler = { [weak self] (indexPath) in
            if let tappedItemVM = self?.dataSource?.provider.item(at: indexPath) {
                self?.coordinator?.showDetailPage(viewModel: tappedItemVM)
            }
        }
        self.listingView.collectionView.reloadData()
    }
    func addItemToCart(index: IndexPath) {
        if let viewModel = dataSource?.provider.item(at: index) {
            manager.appendWishlist(item: viewModel.item)
        }
    }
}
extension ListingViewController: ListingPresenterOutput {
    func showError(error: GenericResponse) {
        ActivityIndicator.shared.hideProgressView()
        if let description = error.localizedDescription {
            SharedAlert.sharedInstance.alert(view: self, title: "Network Request Failed", message: description)
        }
    }
    func showCatalogue(viewModel: ListingViewModel) {
        ActivityIndicator.shared.hideProgressView()
        Logger.log(msg: "Hidden")
        setupDataSource(viewModel: viewModel)
    }
}

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
}
