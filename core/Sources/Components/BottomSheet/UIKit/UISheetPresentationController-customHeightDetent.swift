//
//  UISheetPresentationController-customHeightDetent.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 14.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UISheetPresentationController.Detent {
    /// Return a custom sheet detent with the view height fitting the expanded size as the custom height.
    /// ```
    /// let controller = ExampleBottomSheetViewController()
    /// if #available(iOS 16.0, *) {
    ///   if let sheet = controller.sheetPresentationController {
    ///     sheet.detents = [.medium(), .large(), .expandedHeight(of: controller.view)]
    ///   }
    /// }
    /// present(controller, animated: true)
    /// ```
    @available(iOS 16.0, *)
    static func expandedHeight(of view: UIView) -> UISheetPresentationController.Detent {
        return .custom { context in
            return min(
                view.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height,
                context.maximumDetentValue - 1)
        }
    }

    /// Return a custom sheet detent with the view height fitting the compressed size as the custom height.
    /// ```
    /// let controller = ExampleBottomSheetViewController()
    /// if #available(iOS 16.0, *) {
    ///   if let sheet = controller.sheetPresentationController {
    ///     sheet.detents = [.medium(), .large(), .compressedHeight(of: controller.view)]
    ///   }
    /// }
    /// present(controller, animated: true)
    /// ```
    @available(iOS 16.0, *)
    static func compressedHeight(of view: UIView) -> UISheetPresentationController.Detent {
        return .custom { context in
            return min(
                view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height,
                context.maximumDetentValue - 1)
        }
    }

    @available(iOS 16.0, *)
    /// A custom detent which is almos the size of the large detent but avoids that the background is scaled.
    static func maxHeight() ->  UISheetPresentationController.Detent {
        return .custom { context in
            return context.maximumDetentValue - 1
        }
    }
}
