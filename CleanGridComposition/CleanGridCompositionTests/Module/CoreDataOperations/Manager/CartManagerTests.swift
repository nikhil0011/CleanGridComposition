//
//  CartManagerTests.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 09/02/22.

import XCTest
@testable import CleanGridComposition
class CartManagerTests: XCTestCase {
    func testIfItemAppends() {
        let manager = CartItemManager()
        manager.clearAll()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])

        manager.appendCart(item: items)
        let count = manager.fetchCart()?.count ?? 0
        XCTAssertEqual(1, count)
    }
    func testIfNoDuplicateItemAppends() {
        let manager = CartItemManager()
        manager.clearAll()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])

        manager.appendCart(item: items)
        manager.appendCart(item: items)
        manager.appendCart(item: items)
        manager.appendCart(item: items)
        manager.appendCart(item: items)
        manager.appendCart(item: items)
        let count = manager.fetchCart()?.count ?? 0
        XCTAssertEqual(1, count)
    }
    func testIfFetchItemReturnCorrectObject() {
        let manager = CartItemManager()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])
        manager.appendCart(item: items)
        let result = manager.fetchCartItem(byIdentifier: "11")
        XCTAssertEqual(items.sku, result?.sku)
    }
    func testIfClearAllDeleteAllItem() {
        let manager = CartItemManager()
        let items = Item(id: "11", sku: "SKU11", image: "", brand: "nil", name: "nil", price: 0, originalPrice: 0, badges: [])
        manager.appendCart(item: items)
        manager.appendCart(item: items)
        manager.appendCart(item: items)
        manager.clearAll()
        let result = manager.fetchCart()
        XCTAssertEqual(result?.count, 0)
    }
}
