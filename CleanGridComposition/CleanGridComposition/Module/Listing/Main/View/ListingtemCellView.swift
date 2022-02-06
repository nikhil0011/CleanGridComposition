//
//  ListingtemCellView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//
import UIKit

class ListingItemCellView: BaseView {
    lazy var titleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    lazy var subTitleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
    }
    lazy var priceLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    lazy var itemImageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.layer.isOpaque = false
        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
    }
    var outerView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setupViews() {
        let infoStack = stack(titleLabel, subTitleLabel, priceLabel, alignment: .top, distribution: .fillProportionally
        ).withMargins(.init(top: 0, left: 8, bottom: 4, right: 8))
        stack(itemImageView.withHeight(180), infoStack, spacing: 3)
    }
}
