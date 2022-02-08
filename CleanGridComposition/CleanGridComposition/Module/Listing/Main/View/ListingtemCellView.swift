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
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setupViews() {
        let infoStack = stack(titleLabel, subTitleLabel, priceLabel, alignment: .top, distribution: .fillProportionally
        ).withMargins(.init(top: 0, left: 2, bottom: 4, right: 2))
        let interactionStackView = stack(interactionView).withHeight(240)
        stack(interactionStackView, infoStack, spacing: 3)
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
