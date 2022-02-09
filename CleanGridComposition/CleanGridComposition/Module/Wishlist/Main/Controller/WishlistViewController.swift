//
//  WishlistViewController.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class WishlistViewController: UIViewController {
    var interactor: WishlistUseCase?
    weak var coordinator: MainCoordinator?
    var dataSource: WishlistDataSource?
    private let manager: WishlistManager = WishlistManager()
    lazy var listingView: WishlistView = WishlistView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
    func setupView() {
        self.view.backgroundColor = LColor.surface
        self.view.stack(listingView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wishlist"
        addRightBarItem(image: UIImage.App.dismiss, action: #selector(popToPrevious))
        setupView()
        ActivityIndicator.shared.hideProgressView()
    }
    @objc func popToPrevious() {
        coordinator?.dismiss()
    }
    func setupDataSource(viewModel: WishlistViewModel) {
        dataSource = WishlistDataSource(collectionView: listingView.collectionView, array: viewModel.listOfItemVM())
        dataSource?.reloadData = { [weak self] in
            self?.interactor?.fetch()
        }
        self.listingView.collectionView.reloadData()
    }
}
extension WishlistViewController: WishlistPresenterOutput {
    func showCatalogue(viewModel: WishlistViewModel) {
        ActivityIndicator.shared.hideProgressView()
        setupDataSource(viewModel: viewModel)
    }
    
    func showError(error: GenericResponse) {
        ActivityIndicator.shared.hideProgressView()
        SharedAlert.sharedInstance.alert(view: self, title: "Loading Failed", message: "Please try again could not load required data")
    }
}
