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
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity92)
        case .detailTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .titleSmall, color: LColor.primary)
        case .detaillSubTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary, .opacity92)
        case .badgeTitle(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium, color: LColor.primary)
        case .addToBagButton(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium,  color: LColor.surface, backgroundColor: LColor.primary)
        case .removeButton(let text):
            return ListingStyler.TextAttributes(text: text, font: .bodyMedium,  color: LColor.primary, backgroundColor: LColor.surface)

            
        }
    }
}
public protocol TypographyExtensions: UILabel {
    
    var lineHeight: CGFloat? { get set }
    
}

extension UILabel: TypographyExtensions {
    
    public var lineHeight: CGFloat? {
        get { paragraphStyle?.maximumLineHeight }
        set {
            let lineHeight = newValue ?? 0.0
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
            addAttribute(.baselineOffset, value: baselineOffset)
            setParagraphStyleProperty(lineHeight, for: \.minimumLineHeight)
            setParagraphStyleProperty(lineHeight, for: \.maximumLineHeight)
        }
    }

    fileprivate var attributes: [NSAttributedString.Key : Any]? {
        get {
            if let attributedText = attributedText, !attributedText.string.isEmpty {
                return attributedText.attributes(at: 0, effectiveRange: nil)
            } else {
                return nil
            }
        }
    }
    
    fileprivate func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? {
        return attributes?[key] as? AttributeType
    }
    var paragraphStyle: NSParagraphStyle? {
        getAttribute(.paragraphStyle)
    }
}
extension NSAttributedString {
    
    var entireRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
}
extension UILabel {
    fileprivate func setAttribute(_ key: NSAttributedString.Key, value: Any?) {
        if let value = value {
            addAttribute(key, value: value)
        } else {
            removeAttribute(key)
        }
    }
    
    fileprivate func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.addAttribute(key, value: value, range: attributedText.entireRange)
            self.attributedText = mutableAttributedText
        } else {
            self.attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
        }
    }
    
    fileprivate func removeAttribute(_ key: NSAttributedString.Key) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.removeAttribute(key, range: attributedText.entireRange)
            self.attributedText = mutableAttributedText
        }
    }
}
extension UILabel {
    
    func setParagraphStyleProperty<ValueType>(
        _ value: ValueType,
        for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>
    ) {
        let mutableParagraphStyle = NSMutableParagraphStyle()
        if let paragraphyStyle = paragraphStyle {
            mutableParagraphStyle.setParagraphStyle(paragraphyStyle)
        }
        mutableParagraphStyle[keyPath: keyPath] = value
        setAttribute(.paragraphStyle, value: mutableParagraphStyle)
    }
}
