//
//  ListingItemCollectionViewCell.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class ListingItemCollectionViewCell: BaseCollectionViewCell, ConfigurableCell {
    let styler = ListingStyler.myModule
    lazy var cellView: ListingItemCellView = ListingItemCellView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.backgroundColor = LColor.surface500
    }
    let networker = ImageLoader.shared
    var respresntedIndentifier: String = ""
  
    override func prepareForReuse() {
        self.cellView.interactionView.imageView.itemImageView.image = nil
    }

    override func setupViews() {
        backgroundColor = LColor.surface.alpha(with: .opacity24)
        stack(cellView)
    }
    
    func configure(_ item: ListingItemViewModel, at indexPath: IndexPath) {
        let id = item.id
        if self.respresntedIndentifier == id {
            self.cellView.setupInfo(viewModel: item)
        }
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

