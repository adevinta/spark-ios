//
//  TabViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class TabViewModel: ObservableObject {

    private var useCase: TabsGetAttributesUseCase
    var theme: Theme {
        didSet {
            self.tabsAttributes = self.useCase.execute(theme: theme)
        }
    }

    @Published var apportionsSegmentWidthsByContent: Bool = false
    @Published var tabsAttributes: TabsAttributes

    init(theme: Theme,
         apportionsSegmentWidthsByContent: Bool = false,
         useCase: TabsGetAttributesUseCase = .init()
    ) {
        self.theme = theme
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        self.useCase = useCase
        self.tabsAttributes = useCase.execute(theme: theme)
    }
}
