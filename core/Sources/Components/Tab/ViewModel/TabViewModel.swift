//
//  TabViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SparkTheming

final class TabViewModel<Content>: ObservableObject {

    // MARK: - Private variables
    private var useCase: any TabsGetAttributesUseCaseable

    // MARK: - Internal variables
    var theme: Theme {
        didSet {
            self.tabsAttributes = self.useCase.execute(theme: theme, size: self.tabSize, isEnabled: self.isEnabled)
        }
    }

    // Disable/Enable each tab in the tab control.
    // The whole tab is regarded as enabled, if all tabs are enabled.
    // When set, each tab will be disabled or enabled.
    // To disable a single tab, use the function `disableTab`.
    private (set) var isEnabled: Bool {
        didSet {
            self.tabsAttributes = self.useCase.execute(theme: theme, size: self.tabSize, isEnabled: self.isEnabled)
        }
    }

    var tabSize: TabSize {
        didSet {
            guard self.tabSize != oldValue else { return }
            self.tabsAttributes = self.useCase.execute(theme: theme, size: self.tabSize, isEnabled: self.isEnabled)
        }
    }

    var numberOfTabs: Int {
        return self.content.count
    }

    // MARK: - Published variables
    @Published var disabledTabs: [Bool]
    @Published var apportionsSegmentWidthsByContent: Bool = false
    @Published var tabsAttributes: TabsAttributes
    @Published var content: [Content]
    @Published var isScrollable = false

    // MARK: - Initializer
    init(theme: some Theme,
         apportionsSegmentWidthsByContent: Bool = false,
         content: [Content],
         tabSize: TabSize,
         useCase: some TabsGetAttributesUseCaseable = TabsGetAttributesUseCase()
    ) {
        self.theme = theme
        self.tabSize = tabSize
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        self.useCase = useCase
        self.content = content
        self.disabledTabs = content.map{ _ in return false }
        self.tabsAttributes = useCase.execute(theme: theme, size: tabSize, isEnabled: true)
        self.isEnabled = true
    }

    // Disable or enable a single tab.
    func disableTab(_ disabled: Bool, index: Int) {
        guard index < self.content.count else { return }
        guard self.disabledTabs[index] != disabled else { return }

        self.disabledTabs[index] = disabled
    }

    func isTabEnabled(index: Int) -> Bool {
        return !self.disabledTabs[index] && self.isEnabled
    }

    @discardableResult
    func setIsEnabled(_ isEnabled: Bool) -> Self {
        guard self.isEnabled != isEnabled else { return self }

        self.isEnabled = isEnabled
        return self
    }
}
