//
//  BaseCollectionViewCell.swift
//  CleanCompositionList
//
//  Created by Nikhil Nangia on 31/01/22.
//

import UIKit
// ListCell represents a cell that ListHeaderController registers and dequeues for list rendering. T represents the Class Type, usually a model or view model object, this cell should render visually.
open class BaseCollectionViewCell: UICollectionViewCell {
    
    /// parentController is set to the ListHeaderController that is rendering this cell.  This is useful for scenarios where a cell contains a UIButton and you want to use addTarget(...) to trigger an action in the controller.
    open weak var parentController: UIViewController?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /// In your custom ListCell classes, just override setupViews() to provide custom behavior.  We do this to avoid overriding init methods.
    open func setupViews() {}
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
