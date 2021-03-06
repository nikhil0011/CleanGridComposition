//
//  CartItemManager.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//

import Foundation
struct CartItemManager {
    private let cartItemDataRepository: CartDataRepository = CartDataRepository()

    func appendCart(item: Item) {
        if fetchCartItem(byIdentifier: item.id) == nil {
            cartItemDataRepository.createCart(item: item)
        }
    }

    func fetchCart() -> [Item]? {
        return cartItemDataRepository.getAll()
    }

    func fetchCartItem(byIdentifier id: String) -> Item?
    {
        return cartItemDataRepository.get(byIdentifier: id)
    }

    func updateCart(item: Item) -> Bool {
        return cartItemDataRepository.updateCart(item: item)
    }

    func deleteCartItem(id: String) -> Bool {
        return cartItemDataRepository.delete(id: id)
    }
    func clearAll() {
        let items = fetchCart()
        items?.forEach {
            _ = deleteCartItem(id: $0.id)
        }
    }
}
