//
//  UIViewExtension.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 20/06/2023.
//

import UIKit

extension UIView{
    func setCornerRadiusWithShadow(cornerRadius: CGFloat){
        //create corner view with the same frame and color
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = backgroundColor
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        //add the container view to self
        addSubview(containerView)
        sendSubviewToBack(containerView)
        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
