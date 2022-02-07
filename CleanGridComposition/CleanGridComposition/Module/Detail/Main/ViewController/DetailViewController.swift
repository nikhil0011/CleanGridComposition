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
        self.title = viewModel?.title
        self.view.addSubview(detailView)
        detailView.fillSuperview()
        setup(viewModel: viewModel)
    }
    func setup(viewModel: ListingItemViewModel?) {
        guard let model = viewModel else {
            return
        }
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
        //
    }
}
extension DetailViewController: DetailViewDelegate {
    func addItemToBag() {
        if let result = viewModel?.item {
            manager.appendCart(item: result)
        }
        fetchall()
    }
    func fetchall() {
        let results = manager.fetchCart()
        results?.forEach {
            Logger.log(type: .info, msg: $0.name ?? "")
        }
    }
}
