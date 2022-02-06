//
//  ImageCache.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
import Foundation
import UIKit.UIImage

// Declares in-memory image cache
public protocol ImageCacheType: AnyObject {
    // Returns the image data associated with a given url
    func image(for url: URL) -> Data?
    // Inserts the image data of the specified url in the cache
    func insertImage(_ data: Data?, for url: URL)
    // Removes the image data of the specified url in the cache
    func removeImage(for url: URL)
    // Removes all images data from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> Data? { get set }
}

public final class ImageCache: ImageCacheType {

    private lazy var imageCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.countLimit = config.countLimit
        return cache
    }()
   
    private let config: Config

    public struct Config {
        public let countLimit: Int
        public let memoryLimit: Int

        public static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    public func image(for url: URL) -> Data? {
        if let imageData = imageCache.object(forKey: url.absoluteString as NSString) {
          return imageData as Data
        }
        return nil
    }

    public func insertImage(_ data: Data?, for url: URL) {
        if let result = data as NSData? {
            self.imageCache.setObject(result, forKey: url.absoluteString as NSString)
        }
    }

    public func removeImage(for url: URL) {
        imageCache.removeObject(forKey: url.absoluteString as NSString)
    }

    public func removeAllImages() {
        imageCache.removeAllObjects()
    }

    public subscript(_ key: URL) -> Data? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}
