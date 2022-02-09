//
//  CDWishlistManager.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
struct WishlistManager {
    private let wishlistDataRepository: WishlistDataRepository = WishlistDataRepository()
    
    func appendWishlist(item: WISHLIST_ITEM) {
        wishlistDataRepository.create(wishlist: item)
    }
    
    func fetchWishlist() -> [WISHLIST_ITEM]? {
        return wishlistDataRepository.getAll()
    }
    
    func fetchWishlistItem(byIdentifier id: String) -> WISHLIST_ITEM?
    {
        return wishlistDataRepository.get(byIdentifier: id)
    }
    
    func updateWishlist(item: WISHLIST_ITEM) -> Bool {
        return wishlistDataRepository.update(wishlist: item)
    }
    
    func deleteWishlistItem(id: String) -> Bool {
        return wishlistDataRepository.delete(id: id)
    }
    func clearAll() {
        let items = fetchWishlist()
        items?.forEach {
            _ = deleteWishlistItem(id: $0.id)
        }
    }

}
