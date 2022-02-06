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

    lazy var listingView: ListingView = ListingView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
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
        var itemViewModelList: [ListingItemViewModel] = [ListingItemViewModel]()
        viewModel.data.items.forEach {
            let itemViewModel = ListingItemViewModel(item: $0, section: .catalogue)
            itemViewModelList.append(itemViewModel)
        }
        dataSource = ListingDataSource(collectionView: listingView.collectionView, array: itemViewModelList)
        dataSource?.collectionItemSelectionHandler = { [weak self] (indexPath) in
            if let tappedItemVM = self?.dataSource?.provider.item(at: indexPath) {
                self?.coordinator?.showDetailPage(viewModel: tappedItemVM)
            }
        }
        self.listingView.collectionView.reloadData()
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

