//
//  CDCartItem+CoreDataProperties.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
//

import Foundation
import CoreData


extension CDCartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCartItem> {
        return NSFetchRequest<CDCartItem>(entityName: "CDCartItem")
    }

    @NSManaged public var id: String
    @NSManaged public var sku: String
    @NSManaged public var badges: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Int64
    @NSManaged public var brand: String?
    @NSManaged public var name: String?
    func makeItem() -> Item {
        Item(id: id, sku: sku, image: image, brand: brand, name: name, price: Int(price), originalPrice: nil, badges: [badges ?? ""])
    }
}

extension CDCartItem : Identifiable {

}
