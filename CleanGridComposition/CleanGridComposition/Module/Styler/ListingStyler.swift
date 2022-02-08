//
//  ListingStyler.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

class ListingStyler {
    enum TextStyle {
        case listingCellTitle(_ text: String)
        case listingCellSubTitle(_ text: String)
        case detailTitle(_ text: String)
        case detaillSubTitle(_ text: String)
        case badgeTitle(_ text: String)
        case addToBagButton(_ text: String)
        case removeButton(_ text: String)
        case wishlistCellTitle(_ text: String)
        case wishlistCellSubTitle(_ text: String)
        case wishlistCellPrice(_ text: String)

    }
    
    struct TextAttributes {
        let font: AliasFontToken
        let color: UIColor
        let backgroundColor: UIColor?
        let text: String
        var opacity: Opacity = .opacity100
        init(text: String, font: AliasFontToken, color: UIColor, backgroundColor: UIColor? = nil, _ opacity: Opacity = .opacity100) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
            self.text = text
            self.opacity = opacity
        }
    }
    // MARK: - General Properties
    let backgroundColor: UIColor
    let preferredStatusBarStyle: UIStatusBarStyle
    
    let attributesForStyle: (_ style: TextStyle) -> TextAttributes
    
    init(backgroundColor: UIColor,
         preferredStatusBarStyle: UIStatusBarStyle = .default,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes)
    {
        self.backgroundColor = backgroundColor
        self.preferredStatusBarStyle = preferredStatusBarStyle
        self.attributesForStyle = attributesForStyle
    }
    
    // MARK: - Convenience Getters
    func font(for style: TextStyle) -> AliasFontToken {
        return attributesForStyle(style).font
    }
    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }
    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
    func apply(textStyle: TextStyle, to label: UILabel) {
        label.numberOfLines = 0
        let attributes = attributesForStyle(textStyle)
        let attributedText = NSMutableAttributedString(attributedString: attributes.text.typographicText(color: attributes.color, font: attributes.font, opacity: attributes.opacity))
        label.attributedText = attributedText
        label.lineHeight = 16
    }
    func apply(textStyle: TextStyle, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        let attributedText = NSMutableAttributedString(attributedString: attributes.text.typographicText(color: attributes.color, font: attributes.font, opacity: attributes.opacity))
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.lineHeight = 16
        
    }
}
extension UIImage {
    struct App {
        static let wishlist = "wishlist"
        static let placeholderImage = "placeholder"
        static let delete = "delete"
    }
}
