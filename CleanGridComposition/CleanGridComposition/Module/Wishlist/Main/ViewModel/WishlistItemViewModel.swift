//
//  WishlistItemViewModel.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
struct WishlistItemViewModel {
    let item: WISHLIST_ITEM
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
