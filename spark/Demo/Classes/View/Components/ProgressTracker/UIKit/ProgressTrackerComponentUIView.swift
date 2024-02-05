//
//  ProgressTrackerComponentUIView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 26.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
@testable import SparkCore
import Spark

final class ProgressTrackerComponentUIView: ComponentUIView {

    private var componentView: ProgressTrackerUIControl!

    // MARK: - Properties
    private let viewModel: ProgressTrackerComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var sizeConstraints = [NSLayoutConstraint]()

    // MARK: - Initializer
    init(viewModel: ProgressTrackerComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeProgressTrackerView(viewModel: viewModel)

        super.init(viewModel: viewModel, componentView: componentView)

        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeProgressTrackerView(viewModel: ProgressTrackerComponentUIViewModel) -> ProgressTrackerUIControl {
        let view: ProgressTrackerUIControl

        let content = viewModel.content.makeContent(currentPageIndex: viewModel.selectedPageIndex)
        if viewModel.showLabels {
            let labels: [String] = (0..<content.numberOfPages).map { index in
                return viewModel.title.map{"\($0)-\(index)"} ?? "??"
            }
            view = ProgressTrackerUIControl(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                labels: labels,
                orientation: viewModel.orientation
            )
        } else {
            view = ProgressTrackerUIControl(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                numberOfPages: content.numberOfPages,
                orientation: viewModel.orientation
            )
        }
        view.showDefaultPageNumber = content.showDefaultPageNumber
//        view.currentPage = content.currentPageIndex
        return view
    }

    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.viewModel.sizeConfigurationItemViewModel.buttonTitle = size.name
            self.componentView.size = size
        }

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.componentView.variant = variant
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$orientation.subscribe(in: &self.cancellables) { [weak self] orientation in
            guard let self = self else { return }
            self.viewModel.orientationConfigurationItemViewModel.buttonTitle = orientation.name
            self.componentView.orientation = orientation
        }

        self.viewModel.$content.subscribe(in: &self.cancellables) { [weak self] contentType in
            guard let self = self else { return }

            let content = contentType.makeContent(currentPageIndex: self.viewModel.selectedPageIndex)

            self.viewModel.contentConfigurationItemViewModel.buttonTitle = contentType.name

            self.componentView.showDefaultPageNumber = content.showDefaultPageNumber
            self.componentView.numberOfPages = content.numberOfPages

            for i in 0..<content.numberOfPages {
                let content = content.content(atIndex: i)
                self.componentView.setIndicatorLabel(content.label, forIndex: i)
                self.componentView.setIndicatorImage(content.indicatorImage, forIndex: i)
            }
        }

        self.viewModel.$showLabels.dropFirst().subscribe(in: &self.cancellables) { showLabels in
            let content = self.viewModel.content.makeContent(currentPageIndex: self.viewModel.selectedPageIndex)
            for i in 0..<content.numberOfPages {
                let label: String? = showLabels ? "\(self.viewModel.title) \(i)" : nil
                self.componentView.setLabel(label, forIndex: i)
            }
        }

        self.viewModel.$title.dropFirst().subscribe(in: &self.cancellables) { title in
            let content = self.viewModel.content.makeContent(currentPageIndex: self.viewModel.selectedPageIndex)
            for i in 0..<content.numberOfPages {
                let label: String? = self.viewModel.showLabels ? title.map{"\($0)-\(i)"} : nil
                self.componentView.setLabel(label, forIndex: i)
            }
        }

        self.viewModel.$selectedPageIndex.dropFirst().subscribe(in: &self.cancellables) { pageIndex in

            self.componentView.currentPageIndex = pageIndex
        }

        self.viewModel.$isDisabled.subscribe(in: &self.cancellables) { [weak self] isDisabled in
            guard let self else { return }
            self.componentView.isEnabled = !isDisabled
        }

        self.viewModel.$isTouchable.subscribe(in: &self.cancellables) { [weak self] isTouchable in
            guard let self else { return }
            self.componentView.isUserInteractionEnabled = isTouchable
        }
    }
}
