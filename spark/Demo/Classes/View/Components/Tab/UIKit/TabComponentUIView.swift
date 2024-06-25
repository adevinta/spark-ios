//
//  TabComponentUIView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 06.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import SparkCore
import UIKit

final class TabComponentUIView: ComponentUIView {
    // MARK: - Components
    private let componentView: TabUIView

    // MARK: - Properties

    private let viewModel: TabComponentUIViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(viewModel: TabComponentUIViewModel) {
        self.viewModel = viewModel
        let componentView = Self.makeTabView(viewModel)
        self.componentView = componentView

        super.init(
            viewModel: viewModel,
            integrationStackViewAlignment: .fill,
            componentView: componentView
        )

        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subscribe
    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.viewModel.sizeConfigurationItemViewModel.buttonTitle = size.name
            self.componentView.tabSize = size
        }

        self.viewModel.$showLabel.subscribe(in: &self.cancellables) { [weak self] showLabel in
            guard let self = self else { return }

            for index in 0..<self.viewModel.numberOfTabs {
                let title = showLabel ? self.viewModel.title(at: index) : nil
                self.componentView.setTitle(title, forSegmentAt: index)
            }
        }

        self.viewModel.$showLongLabel.subscribe(in: &self.cancellables) { [weak self] showLongLabel in
            guard let self = self, self.viewModel.showLabel else { return }

            let index = self.componentView.segments.count > 1 ? 1 : 0

            if showLongLabel {
                self.componentView.setTitle(self.viewModel.longTitle(at: index), forSegmentAt: index)
            } else if self.viewModel.showLabel {
                self.componentView.setTitle(self.viewModel.title(at: index), forSegmentAt: index)
            } else {
                self.componentView.setTitle(nil, forSegmentAt: index)
            }
        }

        self.viewModel.$showIcon.subscribe(in: &self.cancellables) { [weak self] showIcon in
            guard let self = self else { return }

            for index in 0..<self.componentView.numberOfSegments {
                let image = showIcon ? self.viewModel.image(at: index) : nil
                self.componentView.setImage(image, forSegmentAt: index)
            }
        }

        self.viewModel.$showBadge.subscribe(in: &self.cancellables) { [weak self] showBadge in
            guard let self = self else { return }

            if !showBadge {
                for index in 0..<self.componentView.numberOfSegments {
                    self.componentView.setBadge(nil, forSegementAt: index)
                }
            } else {
                self.componentView.setBadge(
                    self.viewModel.badge,
                    forSegementAt: self.viewModel.badgePosition)
            }
        }

        self.viewModel.$disabledIndex.subscribe(in: &self.cancellables) { [weak self] index in
            self?.componentView.segments.forEach{
                $0.isEnabled = true
            }

            guard let index = index else { return }

            self?.componentView.segments[index].isEnabled = false
        }

        self.viewModel.$isDisabled.subscribe(in: &self.cancellables) { [weak self] isDisabled in
            self?.componentView.isEnabled = !isDisabled
        }

        self.viewModel.$isEqualWidth.subscribe(in: &self.cancellables) { [weak self] equalWidth in
            guard let self = self else { return }

            self.componentView.apportionsSegmentWidthsByContent = !equalWidth
        }

        self.viewModel.$numberOfTabs.subscribe(in: &self.cancellables) { [weak self] numberOfTabs in
            guard let self = self else { return }

            if numberOfTabs < self.componentView.numberOfSegments {
                self.componentView.removeSegment(
                    at: self.componentView.numberOfSegments - 1,
                    animated: true)
            } else {
                let index = numberOfTabs - 1
                let content = self.viewModel.content[index]
                self.componentView.addSegment(with: content.title ?? "")
                self.componentView.setImage(content.icon, forSegmentAt: index)
                self.componentView.setTitle(content.title, forSegmentAt: index)
            }
        }
    }

    // MARK: - Private construction helper
    static private func makeTabView(_ viewModel: TabComponentUIViewModel) -> TabUIView {
        return TabUIView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            tabSize: viewModel.size,
            content: viewModel.content)
    }
}

// MARK: - Extension TabSize
extension TabSize {
    var name: String {
        switch self {
        case .md: return "Medium"
        case .sm: return "Small"
        case .xs: return "Extra Small"
        @unknown default:
            fatalError()
        }
    }
}
