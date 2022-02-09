//
//  UIImageView+Extension.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//


import UIKit
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension UIImageView {
   func roundCorners(radius: CGFloat) {
       self.clipsToBounds = true
       self.layer.cornerRadius = radius
       self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
extension Optional where Wrapped == Data {
    func image() -> UIImage? {
        if let data = self {
            return UIImage(data: data)
        }
        return UIImage(systemName: "picture")
    }
}

