//
//  UIViewController+Present.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

extension UIViewController {

    func present(
        _ viewControllerToPresent: UIViewController,
        isAnimated animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        if let popoverController = viewControllerToPresent.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
            popoverController.permittedArrowDirections = []
        }

        self.present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
