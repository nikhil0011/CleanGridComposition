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
        setupView()
        ActivityIndicator.shared.hideProgressView()
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
        fetchall()
    }
    func fetchall() {
        let results = manager.fetchWishlist()
        results?.forEach {
            Logger.log(type: .info, msg: $0.name ?? "")
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

