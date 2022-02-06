//
//  ReusableCell.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//


import UIKit

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
