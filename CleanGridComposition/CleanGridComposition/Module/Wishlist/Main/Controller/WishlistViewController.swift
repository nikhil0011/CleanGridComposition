//
//  WishlistViewController.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class WishlistViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var dataSource: WishlistDataSource?
    private let manager: WishlistManager = WishlistManager()
    lazy var listingView: WishlistView = WishlistView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface500
    }
    func setupView() {
        self.view.stack(listingView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wishlist"
        setupView()
        ActivityIndicator.shared.hideProgressView()
    }
    func setupDataSource(viewModel: WishlistViewModel) {
        var itemViewModelList: [WishlistItemViewModel] = [WishlistItemViewModel]()
        viewModel.items.forEach {
            let itemViewModel = WishlistItemViewModel(item: $0)
            itemViewModelList.append(itemViewModel)
        }
        dataSource = WishlistDataSource(collectionView: listingView.collectionView, array: itemViewModelList)
        dataSource?.collectionItemSelectionHandler = { [weak self] (indexPath) in
        }
        self.listingView.collectionView.reloadData()
    }
}
extension WishlistViewController: WishlistPresenterOutput {
    func showCatalogue(viewModel: WishlistViewModel) {
        ActivityIndicator.shared.hideProgressView()
        Logger.log(msg: "Hidden")
        setupDataSource(viewModel: viewModel)
    }
    
    func showError(error: GenericResponse) {
        ActivityIndicator.shared.hideProgressView()
        if let description = error.localizedDescription {
            SharedAlert.sharedInstance.alert(view: self, title: "Network Request Failed", message: description)
        }
    }
}
