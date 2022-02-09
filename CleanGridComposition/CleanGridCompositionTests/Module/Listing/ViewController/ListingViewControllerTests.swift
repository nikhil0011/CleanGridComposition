//
//  ListingViewControllerTests.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 09/02/22.
//
import XCTest
@testable import CleanGridComposition
class ListingViewControllerTests: XCTestCase {
    var viewControllerUnderTest: ListingViewController = ListingViewController()
    override func setUp() {
        super.setUp()
        viewControllerUnderTest.loadViewIfNeeded()
    }
  
    func testHasAView() {
        XCTAssertNotNil(viewControllerUnderTest.listingView)
    }
    func testHasACollectionView() {
        XCTAssertNotNil(viewControllerUnderTest.listingView.collectionView)
    }
    func testNavigationTitle() {
        XCTAssertEqual(viewControllerUnderTest.title ?? "Listing", viewControllerUnderTest.viewTitle)
    }
}
