//
//  CheckboxGetSpacingUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol CheckboxGetSpacingUseCaseable {
    func execute(layoutSpacing: some LayoutSpacing, alignment: CheckboxAlignment) -> CGFloat
}

struct CheckboxGetSpacingUseCase: CheckboxGetSpacingUseCaseable {
    func execute(layoutSpacing: some LayoutSpacing, alignment: CheckboxAlignment) -> CGFloat {
        switch alignment {
        case .left: return layoutSpacing.medium
        case .right: return layoutSpacing.xxxLarge
        }
    }
}
