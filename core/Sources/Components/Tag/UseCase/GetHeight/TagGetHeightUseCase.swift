//
//  TagGetHeightUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

// TODO: remove this class if scaledValue works great on UIKit TagView (and remove Spark DynamicContentSize)

// sourcery: AutoMockable
protocol TagGetHeightUseCaseable {
    func execute(from contentSizeCategory: ContentSizeCategory) -> CGFloat
    func execute(from uiContentSizeCategory: UIContentSizeCategory) -> CGFloat
}

struct TagGetHeightUseCase: TagGetHeightUseCaseable {

    // MARK: - Properties

    private let getDynamicContentSizeUseCase: GetDynamicContentSizeUseCaseable

    // MARK: - Initialization

    init(getDynamicContentSizeUseCase: GetDynamicContentSizeUseCaseable = GetDynamicContentSizeUseCase()) {
        self.getDynamicContentSizeUseCase = getDynamicContentSizeUseCase
    }

    // MARK: - Methods

    func execute(from contentSizeCategory: ContentSizeCategory) -> CGFloat {
        let contentSizeCategory = self.getDynamicContentSizeUseCase.execute(from: contentSizeCategory)
        return self.execute(from: contentSizeCategory)
    }

    func execute(from uiContentSizeCategory: UIContentSizeCategory) -> CGFloat {
        let contentSizeCategory = self.getDynamicContentSizeUseCase.execute(from: uiContentSizeCategory)
        return self.execute(from: contentSizeCategory)
    }

    // MARK: - Private Methods

    func execute(from contentSizeCategory: DynamicContentSize) -> CGFloat {
        switch contentSizeCategory {
        case .xLarge:
            return 22
        case .xxLarge:
            return 24
        case .xxxLarge:
            return 26
        case .accessibility1:
            return 32
        case .accessibility2:
            return 38
        case .accessibility3:
            return 45
        case .accessibility4:
            return 50
        case .accessibility5:
            return 60
        default:
            return 20
        }
    }
}
