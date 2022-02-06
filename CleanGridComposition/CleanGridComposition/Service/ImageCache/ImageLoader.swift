//
//  ImageLoader.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
import Foundation
import UIKit
enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}
public final class ImageLoader: NSObject {
    private var cache: ImageCacheType
    static var shared = ImageLoader()
    var session: URLSession?

    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        if let imageData = cache[imageURL] {
            completion(imageData as Data, nil)
            return
        }
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let task = self?.session?.downloadTask(with: imageURL) { localUrl, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(nil, NetworkManagerError.badResponse(response))
                    return
                }
                guard let localUrl = localUrl else {
                    completion(nil, NetworkManagerError.badLocalUrl)
                    return
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let data = try Data(contentsOf: localUrl)
                        self?.cache.insertImage(data, for: imageURL)
                        completion(data, nil)
                    }catch let error {
                        completion(nil, error)
                    }
                }
            }
            task?.resume()
        }
    }
    
    func image(url: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        download(imageURL: url, completion: completion)
    }
}
extension UIImageView {
    func image(url: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        ImageLoader.shared.image(url: url, completion: completion)
    }
}
