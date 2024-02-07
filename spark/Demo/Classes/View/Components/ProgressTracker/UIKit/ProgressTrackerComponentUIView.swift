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

        if viewModel.showLabels {
            let labels: [String] = (0..<viewModel.numberOfPages).map { index in
                return viewModel.title(at: index) ?? "??"
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
                numberOfPages: viewModel.numberOfPages,
                orientation: viewModel.orientation
            )
        }
        view.showDefaultPageNumber = viewModel.contentType == .page
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

        self.viewModel.$contentType.subscribe(in: &self.cancellables) { [weak self] contentType in
            guard let self = self else { return }
            self.updateContent(
                contentType,
                numberOfPages: self.viewModel.numberOfPages,
                useCurrentPageIndicatorImage: self.viewModel.useCurrentPageIndicatorImage)
        }

        self.viewModel.$useCurrentPageIndicatorImage.subscribe(in: &self.cancellables) { useCurrentIndicatorImage in
            self.updateContent(
                self.viewModel.contentType,
                numberOfPages: self.viewModel.numberOfPages,
                useCurrentPageIndicatorImage: useCurrentIndicatorImage)
        }

        self.viewModel.$showLabels.dropFirst().subscribe(in: &self.cancellables) { showLabels in
            self.updateLabels(showLabels: showLabels, numberOfPages: self.viewModel.numberOfPages)
        }

        self.viewModel.$title.dropFirst().subscribe(in: &self.cancellables) { title in
            for i in 0..<self.viewModel.numberOfPages {
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

        self.viewModel.$useCompletedPageIndicator.subscribe(in: &self.cancellables) { useImage in
            self.componentView.setCompletedIndicatorImage(useImage ? self.viewModel.checkmarkImage : nil)
        }

        self.viewModel.$numberOfPages.subscribe(in: &self.cancellables) { numberOfPages in
            self.updateContent(
                self.viewModel.contentType,
                numberOfPages: numberOfPages,
                useCurrentPageIndicatorImage: self.viewModel.useCurrentPageIndicatorImage)
            self.updateLabels(showLabels: self.viewModel.showLabels, numberOfPages: numberOfPages)
            self.componentView.currentPageIndex = self.viewModel.selectedPageIndex
        }
    }

    private func updateLabels(showLabels: Bool, numberOfPages: Int) {
        for i in 0..<numberOfPages {
            let label: String? = showLabels ? self.viewModel.title(at: i) : nil
            self.componentView.setLabel(label, forIndex: i)
        }

    }

    private func updateContent(
        _ contentType: ProgressTrackerComponentUIViewModel.ContentType,
        numberOfPages: Int,
        useCurrentPageIndicatorImage: Bool
    ) {

        self.viewModel.contentConfigurationItemViewModel.buttonTitle = contentType.name

        self.componentView.showDefaultPageNumber = contentType == .page
        self.componentView.numberOfPages = numberOfPages

        self.componentView.setCompletedIndicatorImage(self.viewModel.checkmarkImage)

        switch contentType {
        case .icon:
            for i in 0..<numberOfPages {
                self.componentView.setIndicatorImage(UIImage.standardImage(at: i), forIndex: i)
            }
        case .text:
            for i in 0..<numberOfPages {
                self.componentView.setIndicatorImage(nil, forIndex: i)
                self.componentView.setIndicatorLabel("ABCDEFGH".character(at: i), forIndex: i)
            }
        case .none, .page:
            for i in 0..<numberOfPages {
                self.componentView.setIndicatorImage(nil, forIndex: i)
                self.componentView.setIndicatorLabel(nil, forIndex: i)
            }
        }

        for i in 0..<numberOfPages {
            self.componentView.setCurrentPageIndicatorImage(useCurrentPageIndicatorImage ? UIImage.selectedImage(at: i) : nil, forIndex: i)
        }
    }
}
