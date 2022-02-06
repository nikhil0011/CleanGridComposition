//
//  Theme.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

public enum App {
    case recipe
}

public class Theme {
    public private(set) var light: Color = LightAliasColorToken()
    public private(set) var dark: Color = DarkAliasColorToken()
    public private(set) var font: Font = GlobalFontToken()
    public static let shared = Theme()
    private init() {}
    
    public func setStyle(light : Color, dark : Color, font aFont: Font?) {
        self.light = light
        self.dark = dark
        if let value = aFont {
            self.font = value
        }
    }

    public func setStyle(app : App = .recipe, font aFont: Font?) {
        switch app {
        case .recipe:
            self.light = LightAliasColorToken()
            self.dark = DarkAliasColorToken()
        }
        if let value = aFont {
            self.font = value
        }
    }
}
