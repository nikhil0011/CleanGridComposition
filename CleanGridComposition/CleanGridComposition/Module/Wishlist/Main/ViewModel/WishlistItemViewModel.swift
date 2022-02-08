//
//  WishlistItemViewModel.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
struct WishlistItemViewModel {
    let item: WISHLIST_ITEM
    let id: String
    var title: String
    var subTitle: String
    var price: String
    var badges: [String]?
    var imageUrl: URL?
    init(item: Item) {
        self.id = item.id
        self.title = (item.brand ?? "").uppercased()
        self.subTitle = (item.name ?? "").capitalized
        self.price = "AED \(item.price)"
        self.imageUrl = URL(string: item.image ?? "")
        self.badges = item.badges
        self.item = item
    }
    var itemHeight: CGFloat {
        240
    }
    var itemInset: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    var interItemSpacing: CGFloat {
        1
    }
    var sectionInset: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
