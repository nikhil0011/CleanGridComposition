//
//  ListingPresenter.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation

protocol ListingPresenterOutput {
    func showCatalogue(viewModel: ListingViewModel)
    func showError(error: GenericResponse)

}
final class ListingPresenter: ListingUseCaseOutput {
    let output: ListingPresenterOutput
    init(output: ListingPresenterOutput) {
        self.output = output
    }
    
    func didFetch(data: CatalogueData) {
        output.showCatalogue(viewModel: ListingViewModel(data: data))
    }
    func didSetError(error: GenericResponse) {
        output.showError(error: error)
    }
}
