//
//  DetailView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//  

import UIKit

class DetailView: BaseView {
    lazy var titleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
    }
    lazy var subTitleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    lazy var priceLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
    }
    lazy var itemImageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: UIImage.App.placeholderImage)
    }
    let outerView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    lazy var tagsView: BaseView = BaseView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }

    lazy var badgeView: BadgeView = BadgeView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "#f5f5f5")
    }
    private lazy var addToBag: UIButton = UIButton.create {
        $0.backgroundColor = LColor.primary
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
//        $0.addTarget(self, action: #selector(removeFromCart(sender:)), for: .touchUpInside)
    }
    override func setupViews() {
        backgroundColor = LColor.surface
        let info = stack(titleLabel, subTitleLabel, spacing: 2, alignment: .center, distribution: .fill)
        let price = stack(info, priceLabel, spacing: 4, alignment: .center, distribution: .fill)
        let actionStack = stack(addToBag.withHeight(60))
        actionStack.withMargins(.init(top: 20, left: 20, bottom: 20, right: 20))
        stack(tagsView.withHeight(60), itemImageView.withHeight(300), price, actionStack, distribution: .fill)
        
        setup()
    }
    func setup() {
        ListingStyler.myModule.apply(textStyle: .addToBagButton("Add To Bag".uppercased()), to: addToBag)
    }
}
