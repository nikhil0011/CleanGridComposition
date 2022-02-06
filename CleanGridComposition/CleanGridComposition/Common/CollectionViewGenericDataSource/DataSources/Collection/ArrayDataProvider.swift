//
//  ArrayDataProvider.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

public class ArrayDataProvider<T>: CollectionDataProvider {
    // MARK: - Internal Properties
    var items: [[T]] = []

    // MARK: - Lifecycle
    init(array: [[T]]) {
        items = array
    }
    // MARK: - CollectionDataProvider
    public func numberOfSections() -> Int {
        return items.count
    }
    public func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    public func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
            return nil
        }
        return items[indexPath.section][indexPath.row]
    }

    public func updateItem(at indexPath: IndexPath, value: T) {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
            return
        }
        items[indexPath.section][indexPath.row] = value
    }
    func section(at index: Int) -> [T]? {
        guard index >= 0 && index < items.count else {
            return nil
        }
        return items[index]
    }
}
