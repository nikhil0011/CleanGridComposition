//
//  ListingItemImageView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class ListingItemInteractionView: CardView {
    lazy var imageView: ItemImageView = ItemImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
    lazy var wishlistView: WishlistIcon = WishlistIcon.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
   
    override func setupViews() {
        let buttons = stack(wishlistView).withHeight(60)
        let image = stack(imageView).withHeight(180)
        stack(buttons, image)
    }
}
 

class ItemImageView: BaseView {
    lazy var itemImageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.layer.isOpaque = false
        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
    }
    override func setupViews() {
        stack(itemImageView)
    }
}


class WishlistIcon: BaseView {
    lazy var badge: BadgeView = BadgeView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "#f5f5f5")
    }
    lazy var wishlistIcon: UIButton = UIButton.create {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = false
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.setImage(UIImage(named: UIImage.App.wishlist), for: .normal)
//        $0.addTarget(self, action: #selector(actionDidTap(sender:)), for: .touchUpInside)
    }
    override func setupViews() {
        addSubview(badge)
        addSubview(wishlistIcon)
        wishlistIcon.anchor(top: topAnchor, right: rightAnchor, paddingTop: 6, paddingRight: 6, width: 20, height: 20)
        badge.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 6, paddingRight: 6)
    }
}

class BadgeView: BaseView {
    lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    override func setupViews() {
        addCorner(radius: 2)
        stack(label).padLeft(2).padRight(2)
    }
    func setup(text: String) {
        ListingStyler.myModule.apply(textStyle: .badgeTitle(text), to: label)
    }
}

extension UIView {
    func addCorner(radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
