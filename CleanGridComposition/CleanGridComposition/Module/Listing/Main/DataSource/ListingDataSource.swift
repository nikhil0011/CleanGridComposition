//
//  ListingDataSource.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit
class ListingDataSource: CollectionArrayDataSource<ListingItemViewModel, ListingItemCollectionViewCell> {
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let item = provider.item(at: indexPath) else {
            return UICollectionViewCell()
        }
        switch item.section {
        case .catalogue:
            let cell: ListingItemCollectionViewCell = collectionView.dequeue(for: indexPath)
            let respresentedId = item.id
            cell.respresntedIndentifier = respresentedId
            cell.configure(item, at: indexPath)
            cell.cellView.interactionView.wishlistView.headerViewDelegate = self
            cell.cellView.interactionView.wishlistView.index = indexPath
            return cell
        }
    }
}

extension ListingDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = provider.item(at: indexPath) else { return CGSize.zero }
        let width = collectionView.frame.width - (item.sectionInset.left + item.sectionInset.right)
        let actual = (width / 2 - (item.interItemSpacing * 2))
        return .init(width: actual , height: item.itemHeight)
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
extension ListingDataSource: ItemHeaderViewDelegate {
    func wishlistTapped(index: IndexPath?) {
        let manager = WishlistManager()
        if let indexPath = index, let viewModel = provider.item(at: indexPath) {
            if viewModel.isItemInWishlist {
                manager.deleteWishlistItem(id: viewModel.id)
            } else {
                manager.appendWishlist(item: viewModel.item)
            }
        }
    }
}
