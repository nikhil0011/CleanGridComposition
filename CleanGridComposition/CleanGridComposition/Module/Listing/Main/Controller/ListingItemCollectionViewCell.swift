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
    }
    let networker = ImageLoader.shared
    var respresntedIndentifier: String = ""
  
    override func prepareForReuse() {
        self.cellView.itemImageView.image = nil
    }

    override func setupViews() {
        stack(cellView)
        withBorder(width: 1, color: LColor.primary.alpha(with: .opacity08))
    }
    var listingItemViewModel: ListingItemViewModel! {
        didSet {
            setupInfo()
            setupImage()
        }
    }
    func configure(_ item: ListingItemViewModel, at indexPath: IndexPath) {
        let id = item.id
        if self.respresntedIndentifier == id {
            self.listingItemViewModel = item
        }
    }
    func setupInfo() {
        styler.apply(textStyle: .listingCellTitle(listingItemViewModel.title), to: cellView.titleLabel)
        styler.apply(textStyle: .listingCellSubTitle(listingItemViewModel.subTitle), to: cellView.subTitleLabel)
        styler.apply(textStyle: .listingCellSubTitle(listingItemViewModel.price), to: cellView.priceLabel)
    }
    func setupImage() {
        cellView.itemImageView.image = UIImage(named: UIImage.App.placeholderImage)
        if let url = listingItemViewModel.imageUrl {
            cellView.itemImageView.image(url: url) { [weak self] data, error  in
                let img = data.image()
                DispatchQueue.main.async {
                    self?.cellView.itemImageView.image = img
                }
            }
        }
//        networker.image(url: recipeViewModel.imageUrl) { [weak self] data, error  in
//            let img = data.image()
//            DispatchQueue.main.async {
//                self?.cellView.itemImageView.image = img
//            }
//        }
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

