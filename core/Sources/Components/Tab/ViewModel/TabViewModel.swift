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

    var isEnabled: Bool = true {
        didSet {
            self.tabsAttributes = self.useCase.execute(theme: theme, isEnabled: self.isEnabled)
        }
    }

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
        self.tabsAttributes = useCase.execute(theme: theme, isEnabled: true)
    }
}
