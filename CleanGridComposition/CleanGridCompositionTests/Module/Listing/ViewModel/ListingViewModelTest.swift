//
//  ListingViewModel.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 07/02/22.
//

import XCTest
@testable import CleanGridComposition
class ListingViewModelTest: XCTestCase {
    func test_initFromRecipe() {
        let recipe = Item(id: "22", sku: "AUK2", image: "snm", brand: "aldo", name: "classic shoe", price: 222, originalPrice: nil, badges: [])
        let sut = ListingItemViewModel(item: recipe, section: .catalogue)
        XCTAssertEqual(sut.title, (recipe.brand ?? "").uppercased())
        XCTAssertEqual(sut.subTitle, (recipe.name ?? "").uppercased())
        XCTAssertEqual(sut.price, "\(recipe.price) AED")
        XCTAssertEqual(sut.imageUrl, URL(string: recipe.image ?? "")!)
    }
}
