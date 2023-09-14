//
//  TabViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class TabViewModel<Content>: ObservableObject {

    // MARK: - Private variables
    private var useCase: any TabsGetAttributesUseCaseable

    // MARK: - Internal variables
    var theme: Theme {
        didSet {
            self.tabsAttributes = self.useCase.execute(theme: theme, isEnabled: self.isEnabled)
        }
    }

    var isEnabled: Bool {
        get {
            return self.disabledTabs.reduce(true) { return $0 && !$1 }
        }
        set {
            self.tabsAttributes = self.useCase.execute(theme: theme, isEnabled: newValue)
            self.disabledTabs = self.disabledTabs.map { _ in return !newValue }
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

    // MARK: - Initializer
    init(theme: some Theme,
         apportionsSegmentWidthsByContent: Bool = false,
         content: [Content],
         useCase: some TabsGetAttributesUseCaseable = TabsGetAttributesUseCase()
    ) {
        self.theme = theme
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        self.useCase = useCase
        self.content = content
        self.disabledTabs = content.map{ _ in return false }
        self.tabsAttributes = useCase.execute(theme: theme, isEnabled: true)
    }

    func disableTab(_ disabled: Bool, index: Int) {
        guard index < self.content.count else { return }
        
        self.disabledTabs[index] = disabled
    }
}
