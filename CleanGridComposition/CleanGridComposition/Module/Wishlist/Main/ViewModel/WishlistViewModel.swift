//
//  WishlistViewModel.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
struct WishlistViewModel {
    let items: [WISHLIST_ITEM]
 
    func listOfItemVM() -> [WishlistItemViewModel] {
        var itemViewModelList: [WishlistItemViewModel] = [WishlistItemViewModel]()
        items.forEach {
            let itemViewModel = WishlistItemViewModel(item: $0)
            itemViewModelList.append(itemViewModel)
        }
        return itemViewModelList
    }
}
