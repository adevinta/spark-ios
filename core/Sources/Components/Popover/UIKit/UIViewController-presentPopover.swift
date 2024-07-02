//
//  UIViewController-presentPopover.swift
//  Spark
//
//  Created by louis.borlee on 25/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UIViewController {

    /// Presents a Spark Popover modally.
    /// - Parameters:
    ///   - popoverViewControllerToPresent: The Spark Popover to display over the current view controller’s content
    ///   - sourceView: UIPopoverPresentationController.sourceView
    ///   - sourceRect: UIPopoverPresentationController.sourceRect
    ///   - permittedArrowDirections: UIPopoverPresentationController.permittedArrowDirections
    ///   - flag: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
    func presentPopover(
        _ popoverViewControllerToPresent: PopoverViewController,
        sourceView: UIView,
        sourceRect: CGRect? = nil,
        permittedArrowDirections: UIPopoverArrowDirection = .any,
        animated flag: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        if let popoverPresentationController = popoverViewControllerToPresent.popoverPresentationController {
            popoverPresentationController.passthroughViews = self.view.subviews
            popoverPresentationController.sourceView = sourceView
            if let sourceRect {
                popoverPresentationController.sourceRect = sourceRect
            }
            popoverPresentationController.permittedArrowDirections = permittedArrowDirections
        }
        self.present(popoverViewControllerToPresent, animated: flag)
    }
}
