//
//  WishlistView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class WishlistView: BaseView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = LColor.primary.alpha(with: .opacity08)
        view.contentInset = .init(top: 1, left: 0, bottom: 0, right: 0)
        return view
    }()
    override func setupViews() {
        stack(collectionView)
    }
}
