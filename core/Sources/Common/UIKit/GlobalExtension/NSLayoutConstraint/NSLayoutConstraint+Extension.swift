//
//  NSLayoutConstraint+Extension.swift
//  Spark
//
//  Created by robin.lemaire on 17/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /// Make the view stick to the edges of an other view
    ///
    /// - Parameters:
    ///   - from: the source view
    ///   - to: the destination view
    ///   - insets: All component (top / left / bottom / right) should be positiv (.zero by default)
    static func stickEdges(from: UIView, to: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            from.topAnchor.constraint(equalTo: to.topAnchor, constant: insets.top),
            from.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: insets.left),
            from.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -insets.bottom),
            from.trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -insets.right)
        ])
    }

    static func center(from: UIView, to: UIView) {
        NSLayoutConstraint.activate([
            from.centerXAnchor.constraint(equalTo: to.centerXAnchor),
            from.centerYAnchor.constraint(equalTo: to.centerYAnchor)
        ])
    }
}
