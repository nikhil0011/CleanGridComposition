//
//  ReusableViewProtocol.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

protocol ReusableView: AnyObject { }
extension ReusableView where Self: UIView {
    static var reuseIdentifier: String { String(describing: self) }
}
extension UICollectionViewCell: ReusableView { }
extension UICollectionReusableView: ReusableView { }

extension UICollectionView {
    func defaultReusableview(_ index: IndexPath) -> UICollectionReusableView {
        let view = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                         withReuseIdentifier: UICollectionReusableView.reuseIdentifier, for: index)
        return view
    }
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        register(cell: T.self)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func register<T: UICollectionViewCell>(cell: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    func register<T: UICollectionReusableView>(header: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        
    }
}
