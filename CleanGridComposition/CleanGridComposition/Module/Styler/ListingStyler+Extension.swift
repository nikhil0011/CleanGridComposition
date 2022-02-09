//
//  ListingStyler+Extension.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//
import UIKit
extension ListingStyler {
    static var myModule: ListingStyler {
        return ListingStyler(
            backgroundColor: LColor.surface,
            preferredStatusBarStyle: .lightContent,
            attributesForStyle: { $0.moduleAttributes }
        )
    }
}

private extension ListingStyler.TextStyle {
    var moduleAttributes: ListingStyler.TextAttributes {
        switch self {
        case .listingCellTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyLarge, color: LColor.primary)
        case .listingCellSubTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity64)
        case .detailTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .titleSmall, color: LColor.primary)
        case .detaillSubTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity92)
        case .detailPrice(let text, _):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity92)
        case .badgeTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary)
        case .addToBagButton(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium,  color: LColor.surface, backgroundColor: LColor.primary)
        case .removeButton(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium,  color: LColor.primary, backgroundColor: LColor.surface)
        case .wishlistCellTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyLarge, color: LColor.primary)
        case .wishlistCellSubTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity92)
        case .wishlistCellPrice(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity64)
        }
    }
}
