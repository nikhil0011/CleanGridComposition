//
//  WishlistItemView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
protocol WishlistItemViewDelegate: AnyObject {
    func removeItemTapped(id: String)
}
class WishlistItemView: BaseView {
    let styler = ListingStyler.myModule
    var id: String?

    weak var delegate: WishlistItemViewDelegate?
    lazy var itemImageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.layer.isOpaque = false
        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
    }
    lazy var titleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    lazy var subTitleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
    }
    lazy var priceLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    private lazy var removeButton: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.setImage(UIImage(named: UIImage.App.delete), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(removeFromWishlist(sender:)), for: .touchUpInside)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setupViews() {
        let infoStack = stack(titleLabel.withHeight(20), subTitleLabel.withHeight(40), priceLabel)
        let image = stack(itemImageView.withSize(.init(width: 140, height: 140)))
        let contentView = hstack(image, infoStack, alignment: .top)
        let actionView = stack(removeButton.withSize(.init(width: 120, height: 40)), alignment: .trailing)
        stack(contentView, actionView, spacing: 4)
    }
    @objc func removeFromWishlist(sender: AnyObject) {
        if let itemId = id {
            delegate?.removeItemTapped(id: itemId)
        }
    }
    func setupInfo(viewModel: WishlistItemViewModel) {
        self.id = viewModel.id
        styler.apply(textStyle: .wishlistCellTitle(viewModel.title), to: titleLabel)
        styler.apply(textStyle: .wishlistCellSubTitle(viewModel.subTitle), to: subTitleLabel)
        styler.apply(textStyle: .wishlistCellPrice(viewModel.price), to: priceLabel)
        styler.apply(textStyle: .removeButton("Remove"), to: removeButton)
        setupImage(url: viewModel.imageUrl)
    }
    func setupImage(url: URL?) {
        itemImageView.image = UIImage(named: UIImage.App.placeholderImage)
        if let url = url {
            itemImageView.image(url: url) { [weak self] data, error  in
                let img = data.image()
                DispatchQueue.main.async {
                    self?.itemImageView.image = img
                }
            }
        }
    }
}
