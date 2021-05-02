//
//  UIView+Anchor.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import UIKit

// MARK: - UIView constraints central methods
extension UIView
{
    /// method to add constraint to view to fill with its superview
    open func fillToSuperView()
    {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    /// method to add constraints to view
    /// - Parameters:
    ///   - top: top constriant
    ///   - leading: leading constraint
    ///   - bottom: bottom constraint
    ///   - trailing: trailing constraint
    ///   - padding: padding(top,left,bottom,right)
    ///   - size: hight/width constraint constant value
    open func anchor(top: NSLayoutYAxisAnchor?,leading: NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,trailing: NSLayoutXAxisAnchor?,padding:UIEdgeInsets = .zero,size: CGSize = .zero)
    {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top
        {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading
        {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom
        {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing
        {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0
        {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0
        {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
