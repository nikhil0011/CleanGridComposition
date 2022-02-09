//
//  ListingtemCellView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
import UIKit

class ListingItemCellView: BaseView {
    let styler = ListingStyler.myModule
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
    lazy var interactionView: ListingItemInteractionView = ListingItemInteractionView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
    override func setupViews() {
        addSub(views: interactionView, titleLabel, subTitleLabel, priceLabel)
        interactionView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 240)
        titleLabel.anchor(top: interactionView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingRight: 4)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 4, paddingRight: 4)
        priceLabel.anchor(top: subTitleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingRight: 4)
    }
    func setupInfo(viewModel: ListingItemViewModel) {
        styler.apply(textStyle: .listingCellTitle(viewModel.title), to: titleLabel)
        styler.apply(textStyle: .listingCellSubTitle(viewModel.subTitle), to: subTitleLabel)
        styler.apply(textStyle: .listingCellSubTitle(viewModel.price), to: priceLabel)
        interactionView.wishlistView.badge.setup(text: viewModel.badges?.first ?? "")
        interactionView.imageView.setupImage(url: viewModel.imageUrl)
        interactionView.wishlistView.setup(isItemWishlist: viewModel.isItemInWishlist)
    }
}
