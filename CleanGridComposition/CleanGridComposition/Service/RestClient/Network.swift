//
//  Network.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import Foundation
import Alamofire
typealias HTTPResponse<T: Decodable> = (Result<T, GenericResponse>) -> Void
protocol NetworkClientProtocol {
    static func performRequest<T: Decodable>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>)
}
class Network: NetworkClientProtocol {
   static func performRequest<T: Decodable>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>) {
       guard let router = router else { return }
       router.urlRequest?.log()
        NetworkClient.request(router).responseDecodable(of: T.self) { (response) in
            response.response?.log(response: response)
            switch response.result {
            case let .success(value):
                DispatchQueue.main.async {
                    completion(.success(value))
                }
            case .failure(_):
                var httpError: GenericResponse
                if let data = response.data, let parsedData = try? JSONDecoder().decode(GenericResponse.self, from: data) {
                    httpError = parsedData
                    DispatchQueue.main.async {
                        completion(.failure(httpError))
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = GenericResponse.returnPseudoObj()
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    static func catalogue(completion: @escaping HTTPResponse<CatalogueData>) {
        performRequest(ListingAPIRouter.catalogue, completion: completion)
    }
}
