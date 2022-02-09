//
//  WishlistIcon.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//

import UIKit
protocol ItemHeaderViewDelegate: AnyObject {
    func wishlistTapped(index: IndexPath?)
}
class ItemHeaderView: BaseView {
    var index: IndexPath?
    var isItemWishlist: Bool = false
    weak var headerViewDelegate: ItemHeaderViewDelegate?
    lazy var badge: BadgeView = BadgeView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "#f5f5f5")
    }
    lazy var wishlistIcon: UIButton = UIButton.create {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.setImage(UIImage(named: UIImage.App.wishlist), for: .normal)
        $0.addTarget(self, action: #selector(wishlistTapped(sender:)), for: .touchUpInside)
    }
    override func setupViews() {
        addSubview(badge)
        addSubview(wishlistIcon)
        wishlistIcon.anchor(top: topAnchor, right: rightAnchor, paddingTop: 6, paddingRight: 6, width: 20, height: 20)
        badge.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 6, paddingRight: 6)
    }
    func setup(isItemWishlist: Bool) {
        self.isItemWishlist = isItemWishlist
        let icon = isItemWishlist ? UIImage.App.wishlistMarked : UIImage.App.wishlist
        wishlistIcon.setImage(UIImage(named: icon), for: .normal)
    }
    @objc func wishlistTapped(sender: AnyObject) {
        let icon = isItemWishlist ? UIImage.App.wishlist : UIImage.App.wishlistMarked
        wishlistIcon.setImage(UIImage(named: icon), for: .normal)
        isItemWishlist = !isItemWishlist
        headerViewDelegate?.wishlistTapped(index: index)
    }
}
