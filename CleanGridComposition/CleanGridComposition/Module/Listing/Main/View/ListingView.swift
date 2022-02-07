//
//  ListingView.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

class ListingView: BaseView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = LColor.surface500

        return view
    }()
    override func setupViews() {
        stack(collectionView)
    }
}
