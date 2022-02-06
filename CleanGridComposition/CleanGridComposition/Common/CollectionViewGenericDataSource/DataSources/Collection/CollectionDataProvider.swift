//
//  CollectionDataProvider.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

public protocol CollectionDataProvider {
    associatedtype T

    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?

    func updateItem(at indexPath: IndexPath, value: T)
}
