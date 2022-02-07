//
//  WishlistItemView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class WishlistItemView: BaseView {
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
        $0.backgroundColor = LColor.primary
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        //        $0.addTarget(self, action: #selector(removeFromCart(sender:)), for: .touchUpInside)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup() {
        ListingStyler.myModule.apply(textStyle: .removeButton("Remove".uppercased()), to: removeButton)
    }
    override func setupViews() {
        let infoStack = stack(titleLabel, subTitleLabel, priceLabel, spacing: 2, alignment: .top, distribution: .fillProportionally)
        let image = stack(itemImageView.withSize(.init(width: 120, height: 200)))
        let contentView = hstack(image, infoStack)
        let actionView = stack(removeButton, alignment: .trailing)
        stack(contentView, actionView, spacing: 4)
    }
}
