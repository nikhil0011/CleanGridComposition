//
//  WishlistDataRepository.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
import CoreData

protocol WishlistRepository {
    func create(wishlist: WISHLIST_ITEM)
    func getAll() -> [WISHLIST_ITEM]?
    func get(byIdentifier id: String) -> WISHLIST_ITEM?
    func update(wishlist: WISHLIST_ITEM) -> Bool
    func delete(id: String) -> Bool
}

struct WishlistDataRepository : WishlistRepository {
    func create(wishlist: WISHLIST_ITEM) {
        let cdEmployee = CDWishlist(context: PersistentStorage.shared.context)
        cdEmployee.name = wishlist.name
        cdEmployee.brand = wishlist.brand
        cdEmployee.id = wishlist.id
        cdEmployee.sku = wishlist.sku
        cdEmployee.image = wishlist.image
        cdEmployee.badges = wishlist.badges.first ?? ""
        cdEmployee.price = Int64(wishlist.price)
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [WISHLIST_ITEM]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDWishlist.self)
        var employees : [WISHLIST_ITEM] = []
        result?.forEach({ (cdWishlist) in
            employees.append(cdWishlist.makeItem())
        })
        return employees
    }
    
    func get(byIdentifier id: String) -> WISHLIST_ITEM? {
        let item = getItem(byIdentifier: id)
        guard item != nil else {return nil}
        return item?.makeItem()
     }
    
    func update(wishlist: WISHLIST_ITEM) -> Bool {
        let result = getItem(byIdentifier: wishlist.id)
        guard let cdWishlist = result  else {
            return false
        }
        cdWishlist.name = wishlist.name
        cdWishlist.brand = wishlist.brand
        cdWishlist.id = wishlist.id
        cdWishlist.sku = wishlist.sku
        cdWishlist.image = wishlist.image
        cdWishlist.badges = wishlist.badges.first ?? ""
        cdWishlist.price = Int64(wishlist.price)
        PersistentStorage.shared.saveContext()
        return true
    }
    func delete(id: String) -> Bool {
        let cdWishlist = getItem(byIdentifier: id)
        guard cdWishlist != nil  else {
            return false
        }
        PersistentStorage.shared.context.delete(cdWishlist!)
        return true
    }
    private func getItem(byIdentifier id: String) -> CDWishlist? {
        let fetchRequest = NSFetchRequest<CDWishlist>(entityName: "CDWishlist")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard let resultItem = result else {return nil}
            return resultItem
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
