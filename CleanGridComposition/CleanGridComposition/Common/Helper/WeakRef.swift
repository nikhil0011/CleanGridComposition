//
//  WeakRef.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import Foundation

public final class WeakRef<T: AnyObject> {
    public weak var object: T?
    
    public init(_ object: T) {
        self.object = object
    }
}
extension WeakRef: ListingPresenterOutput where T: ListingPresenterOutput {
    func showError(error: GenericResponse) {
        object?.showError(error: error)
    }
    
    func showCatalogue(viewModel: ListingViewModel) {
        object?.showCatalogue(viewModel: viewModel)
    }
}
extension WeakRef: DetailPresenterOutput where T: DetailPresenterOutput {
    func showItem(viewModel: ListingItemViewModel) {
        object?.showItem(viewModel: viewModel)

    }
    func showError(error: GenericResponse) {
        object?.showError(error: error)
    }
}
extension WeakRef: WishlistPresenterOutput where T: WishlistPresenterOutput {
    func showCatalogue(viewModel: WishlistViewModel) {
        object?.showCatalogue(viewModel: viewModel)

    }
    func showError(error: GenericResponse) {
        object?.showError(error: error)
    }
}


