//
//  BadgeView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//

import UIKit

class BadgeView: CardView {
    lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    override func setupViews() {
        self.cornnerRadius = 2
        stack(label).padLeft(4).padRight(4)
    }
    func setup(text: String) {
        ListingStyler.myModule.apply(textStyle: .badgeTitle(text), to: label)
    }
}

