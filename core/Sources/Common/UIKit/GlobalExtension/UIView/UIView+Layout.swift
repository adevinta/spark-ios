//
//  UIView+Layout.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviewCentered(_ subview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        NSLayoutConstraint.center(from: subview, to: self)
    }
    /// Adds a subview with the same size as the view.
    /// - Parameter subview: subview to be added
    func addSubviewSizedEqually(_ subview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        NSLayoutConstraint.stickEdges(from: subview, to: self)
    }

    /// Activate a constraint of this view in relation to another view.
    /// - Parameters:
    ///   - attribute1: anchor of caller view
    ///   - attribute2: anchor of the other view
    ///   - ofView: view that relates to this view
    ///   - relation: relation of constraint, .equal by default
    ///   - constant: constant of constraint, 0.0 by default
    ///   - multiplier: multiplier of constraint, 1.0 by default
    func activateConstraint(
        from attribute1: NSLayoutConstraint.Attribute,
        to attribute2: NSLayoutConstraint.Attribute,
        ofView: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0.0,
        multiplier: CGFloat = 1.0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        ofView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.constraint(
                from: attribute1,
                to: attribute2,
                ofView: ofView,
                relation: relation,
                constant: constant,
                multiplier: multiplier
            )
        ])
    }

    /// Return an NSConstraint for the caller view.
    /// - Parameters:
    ///   - attribute1: anchor of caller view
    ///   - attribute2: anchor of the other view
    ///   - ofView: view that relates to this view
    ///   - relation: relation of constraint, .equal by default
    ///   - constant: constant of constraint, 0.0 by default
    ///   - multiplier: multiplier of constraint, 10.0 by default
    /// - Returns: NSLayoutConstraint
    func constraint(
        from attribute1: NSLayoutConstraint.Attribute,
        to attribute2: NSLayoutConstraint.Attribute,
        ofView: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0.0,
        multiplier: CGFloat = 1.0
    ) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: self,
            attribute: attribute1,
            relatedBy: relation,
            toItem: ofView,
            attribute: attribute2,
            multiplier: multiplier,
            constant: constant
        )
    }
}
