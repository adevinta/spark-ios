//
//  UIViewController-customHeightDetent.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 14.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Return a custom sheet detent with the view height fitting the expanded size as the custom height.
    /// ```
    /// let controller = ExampleBottomSheetViewController()
    /// if #available(iOS 16.0, *) {
    ///   if let sheet = controller.sheetPresentationController {
    ///     sheet.detents = [.medium(), .large(), controller.expandedHeightDetent]
    ///   }
    /// }
    /// present(controller, animated: true)
    /// ```
    @available(iOS 16.0, *)
    var expandedHeightDetent: UISheetPresentationController.Detent {
        return .custom { context in
            let height = min(
                self.view.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height,
                context.maximumDetentValue - 0.01)

            return height
        }
    }

    /// Return a custom sheet detent with the view height fitting the compressed size as the custom height.
    /// ```
    /// let controller = ExampleBottomSheetViewController()
    /// if #available(iOS 16.0, *) {
    ///   if let sheet = controller.sheetPresentationController {
    ///     sheet.detents = [.medium(), .large(), controller.compressedHeightDetent]
    ///   }
    /// }
    /// present(controller, animated: true)
    /// ```
    @available(iOS 16.0, *)
    var compressedHeightDetent: UISheetPresentationController.Detent {
        return .custom { context in

            let height = min(
                self.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height,
                context.maximumDetentValue - 0.01)

            return height
        }
    }
}

