//
//  NetworkTests.swift
//  CleanGridCompositionTests
//
//  Created by Nikhil Nangia on 09/02/22.
//
//
//  File.swift
//  CleanCompositionListTests
//
//  Created by Nikhil Nangia on 31/01/22.
//

import XCTest
@testable import CleanGridComposition
class NetworkTests: XCTestCase {
    func test_performAlwaysSuccessRequest() {
        AlwaysSuccessOutputSpy.recipes(completion: { (results) in
            switch results {
            case .success(let data):
                XCTAssertEqual(data.count, 1)
                break
            case .failure(_):
                break
            }
        })
    }
    func test_performAlwaysFailedRequest() {
        AlwaysFailedOutputSpy.recipes(completion: { (results) in
            switch results {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error.success, false)
                break
            }
        })
    }
    private class AlwaysSuccessOutputSpy: NetworkClientProtocol {
        static func performRequest<T>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>) where T : Decodable {
            let items = Item(id: "11", sku: "SKU11", image: nil, brand: nil, name: nil, price: 0, originalPrice: nil, badges: [])
            completion(.success([items] as! T))
        }
        static func recipes(completion: @escaping HTTPResponse<[Item]>) {
            performRequest(nil, completion: completion)
        }
        
    }
    private class AlwaysFailedOutputSpy: NetworkClientProtocol {
        static func performRequest<T>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>) where T : Decodable {
            let error = GenericResponse("API Failed")
            completion(.failure(error))

        }
        static func recipes(completion: @escaping HTTPResponse<[Item]>) {
            performRequest(nil, completion: completion)
        }
        
    }
}
