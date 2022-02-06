//
//  Creatable.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit

protocol Creatable: UIView {
    init()
}

extension Creatable {
    static func create(_ builder: (Self) -> Void) -> Self {
        let view = Self.init()
        builder(view)
        return view
    }
    
    func configure(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
}

extension UIView: Creatable {}
