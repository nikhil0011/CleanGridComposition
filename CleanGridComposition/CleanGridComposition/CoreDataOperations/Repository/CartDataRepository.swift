//
//  CartDataRepository.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
import Foundation
import CoreData
protocol CartRepository {
    func createCart(item: Item)
    func getAll() -> [Item]?
    func get(byIdentifier id: String) -> Item?
    func updateCart(item: Item) -> Bool
    func delete(id: String) -> Bool
}

struct CartDataRepository : CartRepository {
    
    
    func createCart(item: Item) {
        let cdCartItem = CDCartItem(context: PersistentStorage.shared.context)
        cdCartItem.name = item.name
        cdCartItem.brand = item.brand
        cdCartItem.id = item.id
        cdCartItem.sku = item.sku
        cdCartItem.image = item.image
        cdCartItem.badges = item.badges.first ?? ""
        cdCartItem.price = Int64(item.price)
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Item]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDCartItem.self)
        var items : [Item] = []
        result?.forEach({ (cdCartItem) in
            items.append(cdCartItem.makeItem())
        })
        return items
    }
    
    func get(byIdentifier id: String) -> Item? {
        let item = getItem(byIdentifier: id)
        guard item != nil else {return nil}
        return item?.makeItem()
    }
    
    func updateCart(item: Item) -> Bool {
        let result = getItem(byIdentifier: item.id)
        guard let cdCartItem = result  else {
            return false
        }
        cdCartItem.name = item.name
        cdCartItem.brand = item.brand
        cdCartItem.id = item.id
        cdCartItem.sku = item.sku
        cdCartItem.image = item.image
        cdCartItem.badges = item.badges.first ?? ""
        cdCartItem.price = Int64(item.price)
        PersistentStorage.shared.saveContext()
        return true
    }
    func delete(id: String) -> Bool {
        let cdCartItem = getItem(byIdentifier: id)
        guard cdCartItem != nil  else {
            return false
        }
        PersistentStorage.shared.context.delete(cdCartItem!)
        return false
    }
    private func getItem(byIdentifier id: String) -> CDCartItem? {
        let fetchRequest = NSFetchRequest<CDCartItem>(entityName: "CDCartItem")
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
