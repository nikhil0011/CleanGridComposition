//
//  ItemImageView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//
import UIKit

class ItemImageView: BaseView {
    lazy var itemImageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.layer.isOpaque = false
        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
    }
    override func setupViews() {
        stack(itemImageView)
    }
    func setupImage(url: URL?) {
        itemImageView.image = UIImage(named: UIImage.App.placeholderImage)
        if let url = url {
            itemImageView.image(url: url) { [weak self] data, error  in
                let img = data.image()
                DispatchQueue.main.async {
                    self?.itemImageView.image = img
                }
            }
        }
    }
}
