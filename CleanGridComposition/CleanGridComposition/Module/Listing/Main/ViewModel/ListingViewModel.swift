//
//  ListingViewModel.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
struct ListingViewModel {
    let data: CatalogueData
    func listOfItemVM() -> [ListingItemViewModel] {
        var itemViewModelList: [ListingItemViewModel] = [ListingItemViewModel]()
        data.items.forEach {
            let itemViewModel = ListingItemViewModel(item: $0, section: .catalogue)
            itemViewModelList.append(itemViewModel)
        }
        return itemViewModelList
    }

}
