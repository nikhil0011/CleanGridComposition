//
//  WishlistManagerTests.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 09/02/22.
//

import XCTest
@testable import CleanGridComposition
class WishlistManagerTests: XCTestCase {
    func testIfItemAppends() {
        let manager = WishlistManager()
        manager.clearAll()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])

        manager.appendWishlist(item: items)
        let count = manager.fetchWishlist()?.count ?? 0
        XCTAssertEqual(1, count)
    }
    func testIfFetchItemReturnCorrectObject() {
        let manager = WishlistManager()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])
        manager.appendWishlist(item: items)
        let result = manager.fetchWishlistItem(byIdentifier: "11")
        XCTAssertEqual(items.sku, result?.sku)
    }
    func testIfClearAllDeleteAllItem() {
        let manager = WishlistManager()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])
        manager.appendWishlist(item: items)
        manager.appendWishlist(item: items)
        manager.appendWishlist(item: items)
        manager.clearAll()
        let result = manager.fetchWishlist()
        XCTAssertEqual(result?.count, 0)
    }
}
