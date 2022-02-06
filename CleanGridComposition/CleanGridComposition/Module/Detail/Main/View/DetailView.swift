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
    lazy var itemImageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: UIImage.App.placeholderImage)
    }
    let outerView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
  
    override func setupViews() {
        backgroundColor = LColor.surface
        let info = stack(titleLabel, subTitleLabel)
        stack(itemImageView.withHeight(300), info).withMargins(.init(top: 12, left: 20, bottom: 8, right: 20))
        self.itemImageView.withBorder(width: 1, color: LColor.primary.alpha(with: .opacity12))
    }
}
