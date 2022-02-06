//
//  ListingItemViewModel.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
struct ListingItemViewModel {
    let id: String
    var title: String
    var subTitle: String
    var price: String
    var badges: [String]?
    var imageUrl: URL?
    let section: ListingViewController.SectionType
    init(item: Item, section: ListingViewController.SectionType) {
        self.id = item.id
        self.title = item.brand
        self.subTitle = item.name
        self.price = "AED\(item.price)"
        self.imageUrl = URL(string: item.image)
        self.badges = item.badges
        self.section = section
    }
    var itemHeight: CGFloat {
        280
    }
    var itemInset: UIEdgeInsets {
        .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    var interItemSpacing: CGFloat {
        8
    }
    var sectionInset: UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}
