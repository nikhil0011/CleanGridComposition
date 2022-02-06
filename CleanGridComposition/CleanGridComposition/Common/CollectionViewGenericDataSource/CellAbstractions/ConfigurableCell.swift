//
//  ConfigurableCell.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//


import UIKit

public protocol ConfigurableCell: ReusableCell {
    associatedtype T

    func configure(_ item: T, at indexPath: IndexPath)
}
