//
//  ListingDataSourceTests.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 09/02/22.
//

import XCTest

import XCTest
@testable import CleanGridComposition
class ListingDataSourceTests: XCTestCase {
    let viewModels = [[ListingItemViewModel(item: Item(id: "11", sku: "SKU11", image: nil, brand: nil, name: nil, price: 0, originalPrice: nil, badges: []), section: .catalogue)]]
    let collection = UICollectionView(frame: .init(origin: .zero, size: .zero), collectionViewLayout: UICollectionViewLayout())
    lazy var dataSourceSpy =  ListingDataSource(collectionView: collection, array: viewModels)
    func testNumberOfRows() {
        let items = dataSourceSpy.provider.numberOfItems(in: 0)
        XCTAssertEqual(items, viewModels[0].count)
    }
    func testNumberOfSection() {
        let items = dataSourceSpy.provider.numberOfSections()
        XCTAssertEqual(items, viewModels.count)
    }
    func testCollectionViewNotNil() {
        let cv = dataSourceSpy.collectionView
        XCTAssertNotNil(cv)
    }
    func testCollectionViewCellNotNil() {
        let cell = dataSourceSpy.collectionView(dataSourceSpy.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? ListingItemCollectionViewCell
        XCTAssertNotNil(cell)
    }
    func testCollectionViewCellFrame() {
        if let cell = dataSourceSpy.collectionView(dataSourceSpy.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? ListingItemCollectionViewCell {
            XCTAssertEqual(cell.frame, .zero)
        }
    }
    func testCollectionViewHasDelegate() {
        XCTAssertNotNil(dataSourceSpy.collectionView.delegate)
    }
    func testCollectionViewHasDataSource() {
        XCTAssertNotNil(dataSourceSpy.collectionView.dataSource)
    }

}
