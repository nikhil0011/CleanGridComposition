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
        self.title = "New In"
        customiseBackItem(image: UIImage.App.dismiss, action: #selector(clearCart))
        addRightBarItem(image: UIImage.App.wishlist, action: #selector(navigateToWishlist))
        setupView()
        ActivityIndicator.shared.showProgressView(self.view)
    }
    
    @objc func navigateToWishlist() {
        coordinator?.showWishlist()
    }
    @objc func clearCart() {
        CartItemManager().clearAll()
        SharedAlert.sharedInstance.alert(view: self, title: "Alert", message: "Cart Cleared")
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
