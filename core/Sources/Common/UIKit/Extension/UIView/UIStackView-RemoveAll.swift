//
//  UIStackView-RemoveAll.swift
//  SparkCore
//
//  Created by michael.zimmermann on 09.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

import UIKit

extension UIStackView {
    @discardableResult
    func removeArrangedSubviews() -> [UIView] {
        return self.arrangedSubviews.reduce([UIView]()) { $0 + [self.detachArrangedSubview($1)] }
    }

    @discardableResult
    func detachArrangedSubview(_ view: UIView) -> UIView {
        self.removeArrangedSubview(view)
        view.removeFromSuperview()
        return view
    }

    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            self.addArrangedSubview(view)
        }
    }
}
