//
//  DetailPresenter.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
import Foundation

protocol DetailPresenterOutput {
    func showItem(viewModel: ListingItemViewModel)
    func showError(error: GenericResponse)

}
final class DetailPresenter {
    let output: DetailPresenterOutput
    init(output: DetailPresenterOutput) {
        self.output = output
    }
    
    func didFetch(viewModel: ListingItemViewModel) {
        output.showItem(viewModel: viewModel)
    }
}
