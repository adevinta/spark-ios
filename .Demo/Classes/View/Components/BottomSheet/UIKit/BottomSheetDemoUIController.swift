//
//  BottomSheetDemoUIController.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 16.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SparkCore
import UIKit

final class BottomSheetDemoUIController: UIViewController {

    var rootView: (UIView & DidTapButtonable)?

    // MARK: - Lifecycle

    override func loadView() {
        view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView?.didTapButton = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
