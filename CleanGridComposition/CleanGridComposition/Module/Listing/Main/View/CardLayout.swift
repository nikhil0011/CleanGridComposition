//
//  CardLayout.swift
//  CleanGridComposition
//
//  Created by Nikhil Nangia on 07/02/22.
//

import UIKit

@IBDesignable class CardView: UIView, BaseViewProtocol {

    var cornnerRadius : CGFloat = 4
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 5
    
    var shadowColour : UIColor = LColor.primary.alpha(with: .opacity08)
    var shadowOpacity : CGFloat = 0.5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    // MARK: Override SetupViews in custom view
    open func setupViews() {
       
    }
}
