//
//  CatalogueData.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
struct CatalogueData: Codable {
    let title, currency: String
    let items: [Item]
}

struct Item: Codable {
    let id, sku: String
    let image: String
    let brand, name: String
    let price: Int
    let originalPrice: Int?
    let badges: [String]
}
