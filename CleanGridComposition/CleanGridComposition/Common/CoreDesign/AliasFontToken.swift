//
//  AliasFontToken.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import Foundation


public enum AliasFontToken {
    case titleLarge
    case titleSmall
    case bodyMedium
    
    func getAttribues() -> [NSAttributedString.Key : Any] {
        switch self {
        case .titleLarge:
            var attributes: [NSAttributedString.Key : Any] = FontStyle.type282.getAttribues()
            attributes[.kern] = LetterSpacing.spacing75.rawValue
            return attributes
        case .titleSmall:
            var attributes: [NSAttributedString.Key : Any] = FontStyle.type162.getAttribues()
            attributes[.kern] = LetterSpacing.spacing100.rawValue
            return attributes
        
        case .bodyMedium:
            var attributes: [NSAttributedString.Key : Any] = FontStyle.type140.getAttribues()
            attributes[.kern] = LetterSpacing.spacing100.rawValue
            return attributes
        
        }
    }
}
