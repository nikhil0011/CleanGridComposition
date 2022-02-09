//
//  DetailView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//  

import UIKit
protocol DetailViewDelegate: AnyObject {
    func addItemToBag()
}
class DetailView: BaseView {
    let styler = ListingStyler.myModule
    weak var delegate: DetailViewDelegate?
    lazy var titleLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.textAlignment = .center
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
    lazy var badgeView: BadgeView = BadgeView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = LColor.surface
    }
    private lazy var addToBag: UIButton = UIButton.create {
        $0.backgroundColor = LColor.primary
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.addTarget(self, action: #selector(addToBag(sender:)), for: .touchUpInside)
    }
    var isItemInCart: Bool = false {
        didSet {
            updateCTA()
        }
    }
    @objc func addToBag(sender: AnyObject) {
        delegate?.addItemToBag()
        isItemInCart = true
    }
    
    override func setupViews() {
        addSub(views: badgeView, itemImageView, titleLabel, subTitleLabel, priceLabel, addToBag)
        badgeView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, height: 60)
        itemImageView.anchor(top: badgeView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, height: 300)
        titleLabel.anchor(top: itemImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 2)
        priceLabel.anchor(top: subTitleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
        addToBag.anchor(top: priceLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 60)
    }
    func setup(viewModel: ListingItemViewModel?) {
        guard let model = viewModel else {
            return
        }
        isItemInCart = model.isItemInCart
        styler.apply(textStyle: .detailTitle(model.title), to: titleLabel)
        styler.apply(textStyle: .detaillSubTitle(model.subTitle), to: subTitleLabel)
        styler.apply(textStyle: .detailPrice(model.price, model.mrp), to: priceLabel)
        setupImage(url: viewModel?.imageUrl)
        updateCTA()
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
    func updateCTA() {
        let text = isItemInCart ? "Item Added To Bag" : "Add To Bag"
        addToBag.isUserInteractionEnabled = !isItemInCart
        styler.apply(textStyle: .addToBagButton(text.uppercased()), to: addToBag)
    }
}
