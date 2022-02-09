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
        $0.contentVerticalAlignment = .bottom
        $0.addTarget(self, action: #selector(removeFromWishlist(sender:)), for: .touchUpInside)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setupViews() {
        addSub(views: itemImageView, titleLabel, subTitleLabel, priceLabel, removeButton)
        itemImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, width: 140, height: 140)
        titleLabel.anchor(top: topAnchor, left: itemImageView.rightAnchor, right: rightAnchor, paddingTop: 20)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: rightAnchor, paddingTop: 2)
        priceLabel.anchor(top: subTitleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: rightAnchor, paddingTop: 16)
        removeButton.anchor(bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10, width: 120, height: 60)
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
                DispatchQueue.main.async {
                    self?.itemImageView.image = data.image()
                }
            }
        }
    }
}
