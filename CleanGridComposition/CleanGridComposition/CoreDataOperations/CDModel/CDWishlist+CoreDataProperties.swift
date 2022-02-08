//
//  CDWishlist+CoreDataProperties.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
//

import Foundation
import CoreData


extension CDWishlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWishlist> {
        return NSFetchRequest<CDWishlist>(entityName: "CDWishlist")
    }

    @NSManaged public var badges: String?
    @NSManaged public var price: Int64
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var id: String
    @NSManaged public var sku: String
    @NSManaged public var brand: String?
    func makeItem() -> WISHLIST_ITEM {
        WISHLIST_ITEM(id: id, sku: sku, image: image, brand: brand, name: name, price: Int(price), originalPrice: nil, badges: [badges ?? ""])
    }
}

extension CDWishlist : Identifiable {

}
