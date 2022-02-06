//
//  ListingUseCase.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
protocol ListingUseCaseOutput {
    func didFetch(data: CatalogueData)
    func didSetError(error: GenericResponse)
}

final class ListingUseCase {
    let output: ListingUseCaseOutput
    init(output: ListingUseCaseOutput) {
        self.output = output
    }
    func fetch() {
        Network.catalogue { (results) in
            switch results {
            case .success(let data):
                self.output.didFetch(data: data)
            case .failure(let error):
                self.output.didSetError(error: error)
            }
        }
    }
}
