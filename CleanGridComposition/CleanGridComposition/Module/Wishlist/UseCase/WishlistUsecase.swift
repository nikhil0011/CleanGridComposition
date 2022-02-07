//
//  WishlistUsecase.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
typealias WISHLIST_ITEM = Item
protocol WishlistUseCaseOutput {
    func didFetch(data: [WISHLIST_ITEM])
    func didSetError(error: GenericResponse)
}

final class WishlistUseCase {
    let manager = WishlistManager()
    let output: WishlistUseCaseOutput
    init(output: WishlistUseCaseOutput) {
        self.output = output
    }
    func fetch() {
        if let items = manager.fetchWishlist() {
            output.didFetch(data: items)
        }
    }
}
