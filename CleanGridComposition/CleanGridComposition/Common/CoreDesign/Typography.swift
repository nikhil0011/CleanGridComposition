//
//  Typography.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

public extension String {
    //Preferred Method
    func typographicText(color: UIColor, font: AliasFontToken, attributes: [NSAttributedString.Key : Any] = [:], opacity: Opacity = .opacity100) -> NSAttributedString {
        var fullAttributes: [NSAttributedString.Key : Any] = font.getAttribues()
        fullAttributes[.foregroundColor] = color.withAlphaComponent(opacity.rawValue)
        attributes.forEach {
            fullAttributes[$0.key] = $0.value
        }
        return NSAttributedString(string: self, attributes: fullAttributes)
    }
    
    //To be used if Alias Token Not Available
    func typographicText(color: UIColor, font: FontStyle, attributes: [NSAttributedString.Key : Any] = [:], opacity: Opacity = .opacity100) -> NSAttributedString {
        var fullAttributes: [NSAttributedString.Key : Any] = font.getAttribues()
        fullAttributes[.foregroundColor] = color.withAlphaComponent(opacity.rawValue)
        attributes.forEach {
            fullAttributes[$0.key] = $0.value
        }
        return NSAttributedString(string: self, attributes: fullAttributes)
    }
}
