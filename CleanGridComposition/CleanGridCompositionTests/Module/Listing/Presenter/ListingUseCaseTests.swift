//
//  ListingUseCaseTests.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 07/02/22.

import XCTest
@testable import CleanGridComposition
class ListingPresenterTests: XCTestCase {

    func testdidFetchPassesRecipes() {
        let spy = OutputSpy()
        let presenter = ListingPresenter(output: spy)
        XCTAssertEqual(spy.sections.count, 0)
        for i in 1...10 {
            let data = CatalogueData(title: "", currency: "", items: [Item(id: "\(i)", sku: "i", image: "", brand: "", name: "", price: 222, originalPrice: 222, badges: [])])
            presenter.didFetch(data: data)
        }
        XCTAssertEqual(spy.sections.count, 10)

    }
    private class OutputSpy: ListingPresenterOutput {
        func showError(error: GenericResponse) {
        }
        
        typealias Form = (ListingViewModel)
        var sections: [Form] = [Form]()
        func showCatalogue(viewModel: ListingViewModel) {
            sections.append(viewModel)
        }
    }
}
