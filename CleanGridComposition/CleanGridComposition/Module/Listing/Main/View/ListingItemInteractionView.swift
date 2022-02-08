//
//  ListingItemImageView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class ListingItemInteractionView: CardView {
    lazy var imageView: ItemImageView = ItemImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
    lazy var wishlistView: ItemHeaderView = ItemHeaderView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
   
    override func setupViews() {
        let buttons = stack(wishlistView).withHeight(60)
        let image = stack(imageView).withHeight(180)
        stack(buttons, image)
    }
}
