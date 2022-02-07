//
//  WishlistPresenter.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//


import Foundation

protocol WishlistPresenterOutput {
    func showCatalogue(viewModel: WishlistViewModel)
    func showError(error: GenericResponse)

}
final class WishlistPresenter: WishlistUseCaseOutput {
    let output: WishlistPresenterOutput
    init(output: WishlistPresenterOutput) {
        self.output = output
    }
    
    func didFetch(data: [WISHLIST_ITEM]) {
        output.showCatalogue(viewModel: WishlistViewModel(items: data))
    }
    func didSetError(error: GenericResponse) {
        output.showError(error: error)
    }
}
