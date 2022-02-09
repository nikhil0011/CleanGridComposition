//
//  WishlistDataSource.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 08/02/22.
//

import UIKit
protocol WishlistDataSourceDelegate: AnyObject {
    func reload()
}
class WishlistDataSource: CollectionArrayDataSource<WishlistItemViewModel, WishlistItemCollectionViewCell> {
    var reloadData: (() -> Void)?
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let item = provider.item(at: indexPath) else {
            return UICollectionViewCell()
        }
        let cell: WishlistItemCollectionViewCell = collectionView.dequeue(for: indexPath)
        let respresentedId = item.id
        cell.respresntedIndentifier = respresentedId
        cell.configure(item, at: indexPath)
        cell.cellView.delegate = self
        return cell
    }
}

extension WishlistDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = provider.item(at: indexPath) else { return CGSize.zero }
        let width = collectionView.frame.width - (item.sectionInset.left + item.sectionInset.right)
        return .init(width: width , height: item.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let item = provider.item(at: IndexPath(item: 0, section: section)) else { return .zero }
        return item.interItemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let item = provider.item(at: IndexPath(item: 0, section: section)) else { return .zero }
        return item.sectionInset
    }
}
extension WishlistDataSource: WishlistItemViewDelegate {
    func removeItemTapped(id: String) {
        let repositoryManager = WishlistManager()
        if repositoryManager.deleteWishlistItem(id: id) {
            reloadData?()
        }
    }
}
