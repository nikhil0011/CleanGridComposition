//
//  Helper.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import Foundation
import UIKit
open class ActivityIndicator {
    var containerView = UIView()
    var progressView = UIImageView()
    var activityIndicator = UIActivityIndicatorView()
    open class var shared: ActivityIndicator {
        struct Static {
            static let instance: ActivityIndicator = ActivityIndicator()
        }
        return Static.instance
    }
    open func showGifProgressView(_ view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        if containerView.frame.origin.y > 0 {
            containerView.frame.origin.y = -64.0
        } else {
            containerView.frame.origin.y = 0.0
        }
        containerView.backgroundColor = UIColor(rgb: 0xffffff).withAlphaComponent(0.3)
        let gif = UIImage.gif(name: "Rolling-1s-200px")
        DispatchQueue.main.async {
            self.progressView.image = gif
        }
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = view.center
        progressView.backgroundColor = UIColor(rgb: 0x444444).withAlphaComponent(0.7)
        progressView.backgroundColor = .clear
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        activityIndicator.isHidden = true
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    // Showing Progress view
    open func showProgressView(_ view: UIView) {
        view.endEditing(true)
        self.containerView.frame = view.frame
        self.containerView.center = view.center
        if self.containerView.frame.origin.y > 0 {
            self.containerView.frame.origin.y = -64.0
        } else {
            self.containerView.frame.origin.y = 0.0
        }
        self.containerView.backgroundColor = UIColor(rgb: 0xffffff).withAlphaComponent(0.3)
        self.progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.progressView.center = view.center
        self.progressView.backgroundColor = UIColor(rgb: 0x444444).withAlphaComponent(0.7)
        self.progressView.clipsToBounds = true
        self.progressView.layer.cornerRadius = 10
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .whiteLarge
        self.activityIndicator.center = CGPoint(x: self.progressView.bounds.width / 2, y: self.progressView.bounds.height / 2)
        self.progressView.addSubview(self.activityIndicator)
        self.containerView.addSubview(self.progressView)
        view.addSubview(self.containerView)
        self.activityIndicator.startAnimating()
    }
    open func hideProgressView() {
        self.activityIndicator.stopAnimating()
        self.containerView.removeFromSuperview()
    }
}

extension UIImage {

    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }

    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }

    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }

    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }

        return gif(data: dataAsset.data)
    }

    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }

        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)

        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1 // Make sure they're not too fast
        }

        return delay
    }

    internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }

        // Swap for modulo
        if a! < b! {
            let c = a
            a = b
            b = c
        }

        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!

            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }

    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }

    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }

            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        // Calculate full duration
        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
        }()

        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)

        return animation
    }

}
