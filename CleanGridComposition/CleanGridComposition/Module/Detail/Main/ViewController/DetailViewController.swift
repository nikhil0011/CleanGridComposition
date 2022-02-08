//
//  DetailViewController.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class DetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    let networker = ImageLoader.shared
    let styler: ListingStyler = ListingStyler.myModule
    var viewModel: ListingItemViewModel?
    lazy var detailView: DetailView = DetailView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
    }
    let manager: CartItemManager = CartItemManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        customiseBackItem(image: UIImage.App.back, action: #selector(popToPrevious))
        enableInteractiveGesture()
        if let viewModel = viewModel {
            self.title = viewModel.title
            setupRightBarItem(image: viewModel.wishlistIcon)
        }
        self.view.addSubview(detailView)
        detailView.fillSuperview()
        setup(viewModel: viewModel)
    }
    @objc func popToPrevious() {
        coordinator?.dismiss()
    }
    @objc func manageWishlist() {
        guard let viewModel = viewModel else { return }
        let manager = WishlistManager()
        if viewModel.isItemInWishlist {
            _ = manager.deleteWishlistItem(id: viewModel.id)
        } else {
            manager.appendWishlist(item: viewModel.item)
        }
        setupRightBarItem(image: viewModel.wishlistIcon)
    }
    func setupRightBarItem(image: String) {
        addRightBarItem(image: image, action: #selector(manageWishlist))
    }
    func setup(viewModel: ListingItemViewModel?) {
        guard let model = viewModel else {
            return
        }
        detailView.isItemInCart = model.isItemInCart
        styler.apply(textStyle: .detailTitle(model.title), to: detailView.titleLabel)
        styler.apply(textStyle: .detaillSubTitle(model.subTitle), to: detailView.subTitleLabel)
        styler.apply(textStyle: .detaillSubTitle(model.price), to: detailView.priceLabel)
        setupImage()
    }
    func setupImage() {
        detailView.itemImageView.image = UIImage(named: UIImage.App.placeholderImage)
        if let url = viewModel?.imageUrl {
            detailView.itemImageView.image(url: url) { [weak self] data, error  in
                let img = data.image()
                DispatchQueue.main.async {
                    self?.detailView.itemImageView.image = img
                }
            }
        }
    }
}
extension DetailViewController: DetailPresenterOutput {
    func showItem(viewModel: ListingItemViewModel) {
        self.viewModel = viewModel
    }
    func showError(error: GenericResponse) {
        SharedAlert.sharedInstance.alert(view: self, title: "Loading Failed", message: "Please try again could not load required data")
    }
}
extension DetailViewController: DetailViewDelegate {
    func addItemToBag() {
        if let result = viewModel?.item {
            manager.appendCart(item: result)
            SharedAlert.sharedInstance.alert(view: self, title: "Item Added", message: "Total Cart Count \(manager.fetchCart()?.count ?? 0)")
        }
    }
}
