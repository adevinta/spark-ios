//
//  TabViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class TabViewModel: ObservableObject {

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

    init(theme: some Theme,
         apportionsSegmentWidthsByContent: Bool = false,
         useCase: some TabsGetAttributesUseCaseable = TabsGetAttributesUseCase()
    ) {
        self.theme = theme
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        self.useCase = useCase
        self.tabsAttributes = useCase.execute(theme: theme, isEnabled: true)
    }
}