//
//  CheckboxGetSpacingUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol CheckboxGetSpacingUseCaseable {
    func execute(layoutSpacing: LayoutSpacing, alignment: CheckboxAlignment) -> CGFloat
}

struct CheckboxGetSpacingUseCase: CheckboxGetSpacingUseCaseable {
    func execute(layoutSpacing: LayoutSpacing, alignment: CheckboxAlignment) -> CGFloat {
        switch alignment {
        case .left: return layoutSpacing.medium
        case .right: return layoutSpacing.xxxLarge
        }
    }
}

//switch self.viewModel.alignment {
//case .left:
//    VStack {
//        self.checkboxView.padding(.trailing, self.horizontalSpacing)
//        Spacer(minLength: 0)
//    }
//    self.labelView
//    Spacer(minLength: 0)
//case .right:
//    self.labelView.padding(.trailing, self.horizontalSpacing * 3)
//    Spacer(minLength: 0)
//    VStack {
//        self.checkboxView
//        Spacer(minLength: 0)
//    }
//}
//}
