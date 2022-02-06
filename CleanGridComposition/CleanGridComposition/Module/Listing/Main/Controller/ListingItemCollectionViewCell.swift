//
//  ListingItemCollectionViewCell.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class ListingItemCollectionViewCell: BaseCollectionViewCell {
    lazy var cellView: ListingItemCellView = ListingItemCellView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }
    let networker = ImageLoader.shared
    var respresntedIndentifier: String = ""
    
    override func prepareForReuse() {
    }

    override func setupViews() {
        stack(cellView)
        cardLayout(radius: 6)
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
