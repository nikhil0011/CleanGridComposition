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
//extension WeakRef: RecipeListingPresenterOutput where T: RecipeListingPresenterOutput {
//    func showError(error: GenericResponse) {
//        object?.showError(error: error)
//    }
//    
//    func showRecipes(viewModel: RecipeListingViewModel) {
//        object?.showRecipes(viewModel: viewModel)
//    }
//}
//
