//
//  WishlistItemCollectionViewCell.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class WishlistItemCollectionViewCell: BaseCollectionViewCell, ConfigurableCell {
    let styler = ListingStyler.myModule
    lazy var cellView: WishlistItemView = WishlistItemView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.backgroundColor = LColor.surface
    }
    let networker = ImageLoader.shared
    var respresntedIndentifier: String = ""
  
    override func prepareForReuse() {
        self.cellView.itemImageView.image = nil
    }

    override func setupViews() {
        backgroundColor = LColor.surface
        stack(cellView).padTop(16).padBottom(16)
    }
    func configure(_ item: WishlistItemViewModel, at indexPath: IndexPath) {
        let id = item.id
        if self.respresntedIndentifier == id {
            cellView.setupInfo(viewModel: item)
        }
    }
}
