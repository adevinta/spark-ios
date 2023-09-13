//
//  TabViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class TabViewModel<Content>: ObservableObject {

    private var useCase: any TabsGetAttributesUseCaseable
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

    @Published var disabledTabs: [Bool]
    @Published var apportionsSegmentWidthsByContent: Bool = false
    @Published var tabsAttributes: TabsAttributes
    @Published var numberOfTabs: Int
    @Published var content: [Content]

    init(theme: some Theme,
         apportionsSegmentWidthsByContent: Bool = false,
         content: [Content],
         useCase: some TabsGetAttributesUseCaseable = TabsGetAttributesUseCase()
    ) {
        self.theme = theme
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        self.useCase = useCase
        self.numberOfTabs = content.count
        self.content = content
        self.disabledTabs = content.map{ _ in return false }
        self.tabsAttributes = useCase.execute(theme: theme, isEnabled: true)
    }

    func disableTab(_ disabled: Bool, index: Int) {
        guard index < self.numberOfTabs else { return }
        
        self.disabledTabs[index] = disabled
    }
}
