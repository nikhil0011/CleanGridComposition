//
//  ListingAPIRouter.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
import Alamofire
enum ListingAPIRouter: APIConfiguration {
    case catalogue
    var method: HTTPMethod {
        switch self {
        case .catalogue: return .get
        }
    }
    var path: String {
        switch self {
        case .catalogue:
            return Endpoint.recipes
        }
    }
    var parameters: Parameters? {
        switch self {
        case .catalogue:
            return nil
        }
    }
    var host: String {
        switch self {
        case .catalogue:
            return BASEURL
        }
    }
   
}
