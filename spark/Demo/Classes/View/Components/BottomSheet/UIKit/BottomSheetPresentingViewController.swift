//
//  BottomSheetPresentingViewController.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 16.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class BottomSheetPresentingViewController: UIViewController {


    // MARK: - Computed Properties

    lazy var rootView = BottomSheetPresentingView()

    // MARK: - Lifecycle

    override func loadView() {
        view = self.rootView
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.presentSheetButton.addAction(UIAction(handler: didPressButton), for: .touchUpInside)
        rootView.presentBottomSheetButton.addAction(UIAction(handler: didPressBottomButton), for: .touchUpInside)
    }

    // MARK: - Private Helpers

    private func didPressBottomButton(_ action: UIAction) {
        let controller = BottomSheetDemoUIController()
        let view = BottomSheetDemoScrollView()
        controller.rootView = view
        let detents: [UISheetPresentationController.Detent]
        if #available(iOS 16.0, *) {
            detents = [.medium(), .maxHeight(), .expandedHeight(of: view)]
        } else {
            detents = [.medium(), .large()]
        }
        if let sheet = controller.sheetPresentationController {
            sheet.detents = detents
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            if #available(iOS 17.0, *) {
                sheet.prefersPageSizing = true
            }
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(controller, animated: true)
    }

    private func didPressButton(_ action: UIAction) {
        let controller = BottomSheetDemoUIController()
        let view = BottomSheetDemoView()
        controller.rootView = view
        let detents: [UISheetPresentationController.Detent]
        if #available(iOS 16.0, *) {
            detents = [.medium(), .maxHeight(), .compressedHeight(of: view)]
        } else {
            detents = [.medium(), .large()]
        }
        if let sheet = controller.sheetPresentationController {
            sheet.detents = detents
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            if #available(iOS 17.0, *) {
                sheet.prefersPageSizing = true
            }
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(controller, animated: true)
    }
}

// MARK: - Builder
extension BottomSheetPresentingViewController {

    static func build() -> BottomSheetPresentingViewController {
        return BottomSheetPresentingViewController()
    }
}
