//
//  SliderHandleViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class SliderHandleViewModel {

    @Published var color: any ColorToken
    @Published var activeIndicatorColor: any ColorToken

    init(color: some ColorToken,
         activeIndicatorColor: some ColorToken) {
        self.color = color
        self.activeIndicatorColor = activeIndicatorColor
    }
}
