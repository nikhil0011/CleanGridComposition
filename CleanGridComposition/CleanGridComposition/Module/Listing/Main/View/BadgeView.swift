//
//  BadgeView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//

import UIKit

class BadgeView: BaseView {
    lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    override func setupViews() {
        addCorner(radius: 2)
        stack(label).padLeft(2).padRight(2)
    }
    func setup(text: String) {
        ListingStyler.myModule.apply(textStyle: .badgeTitle(text), to: label)
    }
}

