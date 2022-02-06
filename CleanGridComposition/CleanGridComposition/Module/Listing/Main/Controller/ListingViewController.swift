//
//  ListingViewController.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//


import UIKit

class ListingViewController: UIViewController {
    enum SectionType {
        case recipes
    }
    weak var coordinator: MainCoordinator?

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
}
extension ListingViewController: ListingPresenterOutput {
    func showError(error: GenericResponse) {
        ActivityIndicator.shared.hideProgressView()
        if let description = error.localizedDescription {
            SharedAlert.sharedInstance.alert(view: self, title: "Network Request Failed", message: description)
        }
    }
    func showRecipes(viewModel: ListingViewModel) {
        ActivityIndicator.shared.hideProgressView()
        Logger.log(msg: "Hidden")
    }
}

