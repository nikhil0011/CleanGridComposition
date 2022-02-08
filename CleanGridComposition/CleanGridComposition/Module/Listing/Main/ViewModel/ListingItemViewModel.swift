//
//  ListingItemViewModel.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
struct ListingItemViewModel {
    let item: Item
    let id: String
    var title: String
    var subTitle: String
    var price: String
    var badges: [String]?
    var imageUrl: URL?
    let section: ListingViewController.SectionType
    var isItemInWishlist: Bool {
        WishlistManager().fetchWishlistItem(byIdentifier: id) != nil
    }
    var isItemInCart: Bool {
        CartItemManager().fetchCartItem(byIdentifier: id) != nil
    }
    var wishlistIcon: String {
        isItemInWishlist ? UIImage.App.wishlistMarked : UIImage.App.wishlist
    }
    init(item: Item, section: ListingViewController.SectionType) {
        self.id = item.id
        self.title = (item.brand ?? "").uppercased()
        self.subTitle = (item.name ?? "").capitalized
        self.price = "AED \(item.price)"
        self.imageUrl = URL(string: item.image ?? "")
        self.badges = item.badges
        self.section = section
        self.item = item
    }
    var itemHeight: CGFloat {
        330
    }
    var itemInset: UIEdgeInsets {
        .init(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    var interItemSpacing: CGFloat {
        4
    }
    var sectionInset: UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
