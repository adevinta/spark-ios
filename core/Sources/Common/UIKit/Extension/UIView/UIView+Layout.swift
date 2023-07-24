//
//  UIView+Layout.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UIView {

    /// Adds a subview with the same size as the view.
    /// - Parameter subview: subview to be added
    public func addSubviewSizedEqually(_ subview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    /// Adding a constraint of this view in relation to another view.
    /// - Parameters:
    ///   - attribute1: anchor of this view
    ///   - attribute2: anchor of the other view
    ///   - ofView: view that relates to this view
    ///   - relation: relation of constraint, .equal by default
    ///   - constant: constant of constraint, 0.0 by default
    ///   - multiplier: multiplier of constraint, 1.0 by default
    public func addConstraint(
        from attribute1: NSLayoutConstraint.Attribute,
        to attribute2: NSLayoutConstraint.Attribute,
        ofView: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0.0,
        multiplier: CGFloat = 1.0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        ofView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: self,
            attribute: attribute1,
            relatedBy: relation,
            toItem: ofView,
            attribute: attribute2,
            multiplier: multiplier,
            constant: constant
        ).isActive = true
    }
}
